//
//  SingleProfileViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 13/04/2023.
//

import UIKit

class SingleProfileViewController: UIViewController {

    
    //@IBOutlet weak var profileImg: UIImageView!
    //@IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var schoolTextField: UITextField!
    //@IBOutlet weak var whiteBackground: UIImageView!
    
    
    var user: Bruger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*nameLabel.text = user?.fornavn

        
        
        profileImg.backgroundColor = UIColor.clear
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = 20
        

        let imgUrl = "http://test-postnord.dk" + (user?.billede)!
        profileImg.downloadUserImg(from: imgUrl)
        
        // Style background
        whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor*/
        
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
