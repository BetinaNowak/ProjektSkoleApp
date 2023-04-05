//
//  SidebarViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import UIKit

class SidebarViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        containerView.clipsToBounds = false
        /*containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        profileImage.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowRadius = 30
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 20).cgPath*/
        containerView.backgroundColor = UIColor.clear
        
        profileImage.backgroundColor = UIColor.clear
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 40
    }
    
    
    
    @IBAction func ProfileActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "profile_segue", sender: nil)
    }
    
    
    @IBAction func InspirationActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "inspiration_segue", sender: nil)
    }
    
}
