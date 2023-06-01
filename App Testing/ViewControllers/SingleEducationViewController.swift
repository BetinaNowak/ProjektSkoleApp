//
//  SingleEducationViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 26/04/2023.
//

import UIKit

class SingleEducationViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var singleImageView: UIImageView!
    
    @IBOutlet weak var singleTitelLabel: UILabel!
    
    @IBOutlet weak var headerByLabel: UILabel!
    
    @IBOutlet weak var headerVarighedLabel: UILabel!
    
    @IBOutlet weak var beskrivelseLabel: UILabel!
    
    @IBOutlet weak var adgangskravLabel: UILabel!
    
    @IBOutlet weak var ansoegningLabel: UILabel!
    
    @IBOutlet weak var jobmulighederLabel: UILabel!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    
    var post: Opslag?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuBtn(menuBtn)


        view.insetsLayoutMarginsFromSafeArea = false
        
        
        singleTitelLabel.text = post?.titel
        beskrivelseLabel.text = post?.beskrivelse
        headerByLabel.text = post?.by
        headerVarighedLabel.text = post?.varighed
        beskrivelseLabel.text = post?.beskrivelse
        adgangskravLabel.text = post?.adgangskrav
        ansoegningLabel.text = post?.optagelse
        jobmulighederLabel.text = post?.jobmuligheder
        
        
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
        singleImageView.downloadedimgfrom(from: imgUrl)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        
    }

    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}




extension UIImageView {
    func downloadedimgfrom(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
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
    func downloadedimgfrom(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedimgfrom(from: url, contentMode: mode)
    }
}

/*
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}*/

