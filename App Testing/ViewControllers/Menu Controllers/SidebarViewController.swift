//
//  SidebarViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 05/04/2023.
//

import UIKit

class SidebarViewController: UIViewController {

    
    var user: Bruger?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Fetch users
        /*NetworkServiceUsers.sharedObj.getUsers { (Bruger) in
            self.user = Bruger
        }*/
        
        
        nameLabel.text = user?.fornavn ?? "navn"
        print(user?.fornavn ?? "navn")
        
        
        containerView.clipsToBounds = false
        containerView.backgroundColor = UIColor.clear
        
        profileImage.backgroundColor = UIColor.clear
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 40
    }
    
    
    
    @IBAction func ProfileActionBtn(_ sender: Any) {
        performSegue(withIdentifier: "profile_segue", sender: nil)
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
        performSegue(withIdentifier: "events_segue", sender: nil)
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
