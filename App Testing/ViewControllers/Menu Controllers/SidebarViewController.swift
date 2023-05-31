//
//  SidebarViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import UIKit

class SidebarViewController: UIViewController {

    
    //var user: Bruger?
    
    var user = [Bruger]()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Fetch user
        NetworkServiceUsers.sharedObj.getUsers { (Users) in
            self.user = Users
            
            self.nameLabel.text = String(self.user[0].fornavn!) + " " + String(self.user[0].efternavn!)
            
            let imgUrl = "http://test-postnord.dk" + (self.user[0].billede!)
            self.profileImage.downloadedUserImg(from: imgUrl)
        }
        
        
        // Image style
        containerView.clipsToBounds = false
        containerView.backgroundColor = UIColor.clear
        
        profileImage.backgroundColor = UIColor.clear
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 33
        
        
    }
    
    
    @IBAction func HomeActionBtn(_ sender: Any) {
        //performSegue(withIdentifier: "home_segue", sender: nil)
    }
    
    @IBAction func ProfileActionBtn(_ sender: Any) {
      //  performSegue(withIdentifier: "profile_segue", sender: nil)
    }
    
    
    
    @IBAction func EducationsActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "educations_segue", sender: nil)
    }
    
    
    @IBAction func InternshipsActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "internships_segue", sender: nil)
    }
    
    
    @IBAction func InspirationActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "inspiration_segue", sender: nil)
    }
    
    
    @IBAction func EventsActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "events_segue", sender: self)
    }
    
    
    
    @IBAction func NewsActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "news_segue", sender: nil)
    }
    
    
    @IBAction func MessagesActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "messages_segue", sender: nil)
    }
    
}



extension UIImageView {
    func downloadedUserImg(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedUserImg(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedUserImg(from: url, contentMode: mode)
    }
}
