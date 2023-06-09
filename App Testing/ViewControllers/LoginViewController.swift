//
//  LoginViewController.swift
//  App Testing
//
//  Created by mediastyle on 08/06/2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "user"))  {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavID") as! PostsViewController2
            self.navigationController?.pushViewController(nextViewController, animated: true)


        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "user")
    }
}
