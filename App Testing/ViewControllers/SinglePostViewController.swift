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
    @IBOutlet weak var beskrivelseLabel: UILabel!
    @IBOutlet weak var virksomhedsnavnLabel: UILabel!
    @IBOutlet weak var telefonLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var postnrLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    
    
    var selectedPost: String?
    
    var post: Opslag?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //singleTitelLabel.text = selectedPost
        singleTitelLabel.text = post?.titel
        beskrivelseLabel.text = post?.beskrivelse
        virksomhedsnavnLabel.text = post?.virksomhedsnavn
        telefonLabel.text = post?.telefon
        emailLabel.text = post?.email
        adresseLabel.text = post?.adresse_1
        postnrLabel.text = post?.post_nr
        byLabel.text = post?.by
        
//        singleImageView.contentMode = .scaleAspectFill
        //singleImageView.translatesAutoresizingMaskIntoConstraints = false
        singleImageView.layer.cornerRadius = 10
//        singleImageView.clipsToBounds = true
        
        let imgUrl = "http://test-postnord.dk" + (post?.cover_billede)!
        
        singleImageView.downloaded(from: imgUrl)
        
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
