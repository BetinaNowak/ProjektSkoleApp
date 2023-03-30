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
    
    
    @IBOutlet weak var singleTitelLabel: UILabel!
    @IBOutlet weak var beskrivelseLabel: UILabel!
    @IBOutlet weak var virksomhedsnavnLabel: UILabel!
    @IBOutlet weak var telefonLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var postnrLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var ansoegButton: UIButton!
    
    
    var selectedPost: String?
    
    var post: Opslag?
        
    var postId: Int?
    var postTitel: String?
    var postEmail: String?
    var postVirksomhedsnavn: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        postId = post!.id!
        postTitel = post!.titel!
        postEmail = post!.email!
        postVirksomhedsnavn = post!.virksomhedsnavn!
        if let AnsoegningViewController = segue.destination as? AnsoegningViewController {
            AnsoegningViewController.postId = self.postId!
            AnsoegningViewController.postTitel = self.postTitel!
            AnsoegningViewController.postEmail = self.postEmail!
            AnsoegningViewController.postVirksomhedsnavn = self.postVirksomhedsnavn!
        }
    }
    
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
        ansoegButton.tag = post!.id!
        
        
        // Shadow
        /*singleImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        singleImageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        singleImageView.layer.shadowOpacity = 0.6
        singleImageView.layer.shadowRadius = 6.0
        
        
        singleImageView.layer.masksToBounds = false
        singleImageView.layer.cornerRadius = 20*/
        //singleImageView.clipsToBounds = true
        
        
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
        
        
        containerView.addSubview(singleImageView)
        
        
        
        let imgUrl = "http://test-postnord.dk" + (post?.cover_billede)!
        
        singleImageView.downloaded(from: imgUrl)
        
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
