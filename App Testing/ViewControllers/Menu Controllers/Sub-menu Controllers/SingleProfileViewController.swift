//
//  SingleProfileViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 13/04/2023.
//

import UIKit

class SingleProfileViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var postnrTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    
    
    //var user: Bruger?
    var user = [Bruger]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch user
        NetworkServiceUsers.sharedObj.getUsers { (Users) in
            self.user = Users
            
            self.nameLabel.text = String(self.user[0].fornavn!) + " " + String(self.user[0].efternavn!)
            
            self.schoolTextField.text = String(self.user[0].skole!)
            
            self.gradeTextField.text = String(self.user[0].klassetrin!)
            
            self.adressTextField.text = String(self.user[0].adresse_1!)
            
            self.postnrTextField.text = String(self.user[0].post_nr!)
            
            self.townTextField.text = String(self.user[0].by!)
            
            
            let imgUrl = "http://test-postnord.dk" + (self.user[0].billede!)
            self.profileImg.downloadUserImg(from: imgUrl)
        }
        
        //nameLabel.text = user?.fornavn

        
        // Image style
        containerView.clipsToBounds = false
        containerView.backgroundColor = UIColor.clear
        
        profileImg.backgroundColor = UIColor.clear
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = 40
        
        
        // Style background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }

}


extension UIImageView {
    func downloadUserImg(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
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
    func downloadUserImg(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadUserImg(from: url, contentMode: mode)
    }
}
