//
//  SidebarViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import UIKit

class SidebarViewController: UIViewController {

    
    var UsersArray = [Bruger]()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Fetch users
        NetworkServiceUsers.sharedObj.getUsers { (Bruger) in
            self.UsersArray = Bruger
            
            //self.postsCollectionView2.reloadData()
            //nameLabel.text = UsersArray.fornavn
        }

        
        containerView.clipsToBounds = false
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
