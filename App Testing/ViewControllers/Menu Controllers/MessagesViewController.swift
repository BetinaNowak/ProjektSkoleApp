//
//  MessagesViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 11/04/2023.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var messagesTableView: UITableView!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    
    
    var ApplicationsArray = [Ansoegning]()
    
    var filteredApplicationsArray = [Ansoegning]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkServiceApplications.sharedObj.getApplications { (Ansoegning) in
            self.ApplicationsArray = Ansoegning
            self.messagesTableView.reloadData()
        }
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        

        setMenuBtn(menuBtn)
        
        // Style background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
        self.messagesTableView.rowHeight = 150.0
        /*messagesTableView.rowHeight = UITableView.automaticDimension
        messagesTableView.estimatedRowHeight = 200*/
        
    }
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return ApplicationsArray.count

        let count = ApplicationsArray.filter { application in
            return application.ansoegning_accepteret == 1 && application.ansoeger_id == 1
        }.count
            
        return count
  
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessagesTableViewCell
        

        // Filter ApplicationsArray to get the application object for this row
            let filteredApplications = ApplicationsArray.filter { application in
                return application.ansoegning_accepteret == 1 && application.ansoeger_id == 1
            }
            
            // Check if the filteredApplications array contains an application object for this row
            if indexPath.row < filteredApplications.count {
                let application = filteredApplications[indexPath.row]
                cell.beskedLabel?.text = "Din ansøgning fra " + application.praktik_virksomhedsnavn! + " er blevet accepteret!"
            }
            
            return cell
    }
    

}
