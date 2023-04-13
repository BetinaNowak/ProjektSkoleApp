//
//  MainTabBarController.swift
//  App Testing
//
//  Created by Betina Svendsen on 12/04/2023.
//
/*
import UIKit

class MainTabBarController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTabBar.clipsToBounds = true

        self.navigationController?.navigationBar.isHidden = true

    }


}*/


import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let homeVC = PostsViewController()
        let profileVC = ProfileViewController()
        
        //homeVC.title = "Hjem"
        profileVC.title = "Profil"
        
        self.setViewControllers([profileVC], animated: false)
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        //self.delegate = self
        
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = ProfileViewController()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "person.fill"), selectedImage: UIImage(named: "person.fill"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = InspirationViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "magnifyingglass"), selectedImage: UIImage(named: "magnifyingglass"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }*/
}
