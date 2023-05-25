//
//  MessageThreadViewController.swift
//  App Testing
//
//  Created by mediastyle on 23/05/2023.
//

import Foundation
import UIKit

class MessageThreadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageThreadTableView: UITableView!
    //@IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var nyBesked: UITextField!
    @IBOutlet weak var whiteBackground: UIImageView!
    
    var chatId: Int?

    @IBAction func sendBesked(_ sender: Any) {
        var beskedArray = [String:Any]()
        beskedArray = [
            String("chat_id"): Int(chatId!),
            String("bruger_fra"): Int(1),
            String("bruger_til"): Int(2),
            String("besked"): String(nyBesked.text!),
        ]
        //print(ansoegningArray)
        
        // Send the responses
        NetworkServicePostMessage.sendBesked(params: beskedArray)
        
        var newBesked = Besked()
        newBesked.chat_id = chatId
        newBesked.bruger_fra = 1
        newBesked.bruger_til = 2
        newBesked.besked = String(nyBesked.text!)
        MessagesArray.append(newBesked)

        messageThreadTableView.beginUpdates()
        messageThreadTableView.insertRows(at: [IndexPath(row: MessagesArray.count-1, section: 0)], with: .automatic)
        messageThreadTableView.endUpdates()
        messageThreadTableView.scrollToRow(at: IndexPath(row: self.MessagesArray.count-1, section: 0), at: .bottom, animated: true)
        nyBesked.text = ""
    }
    
    var MessagesArray = [Besked]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.chatId!)
        
        
        NetworkServiceMessages.sharedObj.getMessages (id: self.chatId!){ (Message) in
            self.MessagesArray = Message
            self.messageThreadTableView.reloadData()
            if(self.MessagesArray.count > 0) {
                self.messageThreadTableView.scrollToRow(at: IndexPath(row: self.MessagesArray.count-1, section: 0), at: .bottom, animated: true)
            }
            
        }
        //print(MessagesArray)

        messageThreadTableView.delegate = self
        messageThreadTableView.dataSource = self
        
        messageThreadTableView.estimatedRowHeight = 20.0
        messageThreadTableView.rowHeight = UITableView.automaticDimension

        //setMenuBtn(menuBtn)
        
        // Style background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
        self.messageThreadTableView.rowHeight = 150.0
        /*messagesTableView.rowHeight = UITableView.automaticDimension
        messagesTableView.estimatedRowHeight = 200*/
        
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredMessages = MessagesArray.filter { message in
            return message.chat_id == chatId
        }
        
        return filteredMessages.count
    }
    
   // func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     //   return UITableView.automaticDimension
    //}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMessage", for: indexPath) as! MessageThreadTableViewCell
        
        // Filter MessagesArray to get the messages from chat 1
            let filteredMessages = MessagesArray.filter { message in
                return message.chat_id == chatId
            }
        let message = filteredMessages[indexPath.row]
        
        cell.beskedLabel?.text = message.besked
        
        if(message.bruger_fra == 1) {
            cell.cellView.layer.backgroundColor = #colorLiteral(red: 0.42594558, green: 0.04593158513, blue: 0.9203953147, alpha: 1)
        }
        
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.3
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowPath = UIBezierPath(roundedRect: cell.cellView.bounds, cornerRadius: 10).cgPath
        
        return cell
    }


    }
    

