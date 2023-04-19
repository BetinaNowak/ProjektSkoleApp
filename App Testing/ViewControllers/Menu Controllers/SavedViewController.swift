//
//  NewsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 11/04/2023.
//

import UIKit

class SavedViewController: UIViewController {

    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    
    
    @IBOutlet weak var savedTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setMenuBtn(menuBtn)
        
        
        // Style background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
    }
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
