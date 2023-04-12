//
//  MainTabBarController.swift
//  App Testing
//
//  Created by Betina Svendsen on 12/04/2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTabBar.clipsToBounds = true

        self.navigationController?.navigationBar.isHidden = true

    }


}
