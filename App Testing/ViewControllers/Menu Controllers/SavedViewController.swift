//
//  NewsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 11/04/2023.
//

import UIKit


class SavedViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var savedPostsArray = [Opslag]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellView"
          let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SavedTableViewCell

          // Fetches the appropriate meal for the data source layout.
          let savedSinglePost = savedPostsArray[indexPath.row]

          cell.titelLabel.text = savedSinglePost.titel
          cell.beskrivelseLabel.text = savedSinglePost.beskrivelse
          cell.byLabel.text = savedSinglePost.by
          cell.varighedLabel.text = savedSinglePost.varighed
        
        let imgUrl = "http://test-postnord.dk" + (savedSinglePost.cover_billede!)
        cell.internshipImageView.downloadedimg(from: imgUrl, contentMode: .scaleAspectFill)
        cell.saveBtn.isSelected = true


          return cell
    }
    
    // Segue for showing single post
    override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        if let destination = seque.destination as? SinglePostViewController {
            destination.post = savedPostsArray[savedTableView.indexPathForSelectedRow!.row]
        }
    }

    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
   // @IBOutlet weak var whiteBackground: UIImageView!
    
    
    @IBOutlet weak var savedTableView: UITableView!
    
    var savedInternship: Opslag?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        savedTableView.delegate = self
        savedTableView.dataSource = self
        
       
        setMenuBtn(menuBtn)
        
        
        // Style custom background
      /*  whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor */
        
        
        // Fetch internship posts
        NetworkServiceSavedPosts.sharedObj.getSavedPosts { (Opslag) in
            self.savedPostsArray = Opslag
            self.savedTableView.reloadData()
        }
        //self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "SavedTableViewCell")
    }
    
    
    

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
