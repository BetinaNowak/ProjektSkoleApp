//
//  ProfileViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 04/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var whiteBackground: UIImageView!
    
    @IBOutlet weak var personalInfoBtn: UIButton!
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var messagesBtn: UIButton!
    @IBOutlet weak var savedPostsBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuBtn(menuBtn)
        
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
        
        // Style buttons
        personalInfoBtn.layer.shadowRadius = 4
        personalInfoBtn.layer.shadowOpacity = 0.5
        personalInfoBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        personalInfoBtn.layer.shadowColor = UIColor.gray.cgColor
        
        eventsBtn.layer.shadowRadius = 4
        eventsBtn.layer.shadowOpacity = 0.5
        eventsBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        eventsBtn.layer.shadowColor = UIColor.gray.cgColor
        
        messagesBtn.layer.shadowRadius = 4
        messagesBtn.layer.shadowOpacity = 0.5
        messagesBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        messagesBtn.layer.shadowColor = UIColor.gray.cgColor
        
        savedPostsBtn.layer.shadowRadius = 4
        savedPostsBtn.layer.shadowOpacity = 0.5
        savedPostsBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        savedPostsBtn.layer.shadowColor = UIColor.gray.cgColor
    }
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
