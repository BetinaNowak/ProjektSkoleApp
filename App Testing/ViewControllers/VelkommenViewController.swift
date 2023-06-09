//
//  VelkommenViewController.swift
//  App Testing
//
//  Created by mediastyle on 09/06/2023.
//

import Foundation
import UIKit

class VelkommenViewController: UIViewController{
    
    
    @IBOutlet weak var velkommenTekst: UILabel!
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        
        velkommenTekst.text = defaults.string(forKey: "fornavn")
    }
    
}
