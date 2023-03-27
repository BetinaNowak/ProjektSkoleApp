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
        
        singleImageView.contentMode = .scaleAspectFill
        
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
