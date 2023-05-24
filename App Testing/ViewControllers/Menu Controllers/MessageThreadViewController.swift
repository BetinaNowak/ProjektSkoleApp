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
    @IBOutlet weak var whiteBackground: UIImageView!

    var MessagesArray = [Besked]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkServiceMessages.sharedObj.getMessages { (Message) in
            self.MessagesArray = Message
            self.messageThreadTableView.reloadData()
        }
        print(MessagesArray)

        messageThreadTableView.delegate = self
        messageThreadTableView.dataSource = self
        

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
            return message.chat_id == 1
        }
        
        return filteredMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMessage", for: indexPath) as! MessageThreadTableViewCell
        
        // Filter MessagesArray to get the messages from chat 1
            let filteredMessages = MessagesArray.filter { message in
                return message.chat_id == 1
            }
        let message = filteredMessages[indexPath.row]
        
        cell.beskedLabel?.text = "message.besked"
        
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.3
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowPath = UIBezierPath(roundedRect: cell.cellView.bounds, cornerRadius: 10).cgPath
        
        return cell
    }


    }
    

