//
//  SinglePostViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 24/03/2023.
//

import UIKit

class SinglePostViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var singleTitelLabel: UILabel!
    @IBOutlet weak var beskrivelseLabel: UILabel!
    @IBOutlet weak var virksomhedsnavnLabel: UILabel!
    @IBOutlet weak var telefonLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var postnrLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    
    @IBOutlet weak var headerByLabel: UILabel!
    @IBOutlet weak var headerVarighedLabel: UILabel!
    
    
    var post: Opslag?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        singleTitelLabel.text = post?.titel
        beskrivelseLabel.text = post?.beskrivelse
        virksomhedsnavnLabel.text = post?.virksomhedsnavn
        telefonLabel.text = post?.telefon
        emailLabel.text = post?.email
        adresseLabel.text = post?.adresse_1
        postnrLabel.text = post?.post_nr
        byLabel.text = post?.by
        
        headerByLabel.text = post?.by
        headerVarighedLabel.text = post?.varighed
        
        
        // Image styling
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        singleImageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowRadius = 30
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 20).cgPath
        containerView.backgroundColor = UIColor.clear
        
        singleImageView.backgroundColor = UIColor.clear
        singleImageView.clipsToBounds = true
        singleImageView.layer.cornerRadius = 20
        
        // Blur view styling
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        
        
        containerView.addSubview(singleImageView)
        
        let imgUrl = "http://test-postnord.dk" + (post?.cover_billede)!
        singleImageView.downloaded(from: imgUrl)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
