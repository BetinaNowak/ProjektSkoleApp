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
        
        
        //savedTableView.delegate = self
        //savedTableView.dataSource = self
        
       
        setMenuBtn(menuBtn)
        
        
        // Style custom background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
        
    }
    
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }*/
    
    
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}

protocol ItemCellDelegate {
    func itemCell(didTapButton button: UIButton)
}  
