//
//  InternshipViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 11/04/2023.
//

import UIKit

class InternshipViewController: UIViewController {

    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        setMenuBtn(menuBtn)
    }
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
