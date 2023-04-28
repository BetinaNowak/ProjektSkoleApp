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
        
        // Filter ApplicationsArray to get the applications submitted by ansoger_id 1
            let filteredApplications = ApplicationsArray.filter { application in
                return application.ansoeger_id == 1
            }
            
            // Count the number of accepted and rejected applications
            let acceptedApplications = filteredApplications.filter { application in
                return application.ansoegning_accepteret == 1
            }
            
            let rejectedApplications = filteredApplications.filter { application in
                return application.ansoegning_accepteret == 0
            }
            
            // Return the total number of accepted and rejected applications
            return acceptedApplications.count + rejectedApplications.count
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessagesTableViewCell
        

        // Filter ApplicationsArray to get the applications submitted by ansoger_id 1
            let filteredApplications = ApplicationsArray.filter { application in
                return application.ansoeger_id == 1
            }
            
            // Determine if the application is accepted or rejected
            let application = filteredApplications[indexPath.row]
            if application.ansoegning_accepteret == 1 {
                cell.beskedLabel?.text = "Din ansøgning fra " + application.praktik_virksomhedsnavn! + " er blevet accepteret!"
            } else {
                cell.beskedLabel?.text = "Din ansøgning fra " + application.praktik_virksomhedsnavn! + " er desværre blevet afvist."
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
    

