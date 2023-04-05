//
//  SidebarViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import UIKit

class SidebarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func ProfileActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "profile_segue", sender: nil)
    }
    
    
    @IBAction func InspirationActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "inspiration_segue", sender: nil)
    }
    
}
