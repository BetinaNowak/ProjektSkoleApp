//
//  SinglePostViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 24/03/2023.
//

import UIKit

class SinglePostViewController: UIViewController {

    
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet weak var singleTitelLabel: UILabel!
    
    
    var selectedPost: String?
    
    var post: Opslag?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //singleTitelLabel.text = selectedPost
        singleTitelLabel.text = post?.titel
        
        
    }
    

}
