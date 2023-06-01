//
//  SinglePostViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 24/03/2023.
//

import UIKit

class SinglePostViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    @IBOutlet weak var singleImageView: UIImageView!
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var singleTitelLabel: UILabel!
    
    @IBOutlet weak var headerByLabel: UILabel!
    
    @IBOutlet weak var headerVarighedLabel: UILabel!
    
    @IBOutlet weak var headerStartdatoLabel: UILabel!
    
    @IBOutlet weak var beskrivelseLabel: UILabel!
    
    @IBOutlet weak var virksomhedsnavnLabel: UILabel!

    @IBOutlet weak var telefonLabel: UILabel!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var adresseLabel: UILabel!
    
    
    @IBOutlet weak var postnrLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    
    @IBOutlet weak var ansoegButton: UIButton!

    
    @IBOutlet weak var successPopUp: UIView!

    
    @IBOutlet weak var closePopUpButton: UIButton!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    
    @IBAction func closePopUp(_ sender: Any) {
        successPopUp.isHidden = true
        backgroundView.isHidden = true
        view.viewWithTag(9)?.removeFromSuperview()
    }
    
    var post: Opslag?
        
    var postId: Int?
    var postTitel: String?
    var postEmail: String?
    var postVirksomhedsnavn: String?
    var postStartdato: String?
    
    var callBack: ((_ status: String)-> Void)?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        postId = post!.id!
        postTitel = post!.titel!
        postEmail = post!.email!
        postVirksomhedsnavn = post!.virksomhedsnavn!
        postStartdato = post!.start_dato!
        if let AnsoegningViewController = segue.destination as? AnsoegningViewController {
            print("it runs")
            AnsoegningViewController.postId = self.postId!
            AnsoegningViewController.postTitel = self.postTitel!
            AnsoegningViewController.postEmail = self.postEmail!
            AnsoegningViewController.postVirksomhedsnavn = self.postVirksomhedsnavn!
            //AnsoegningViewController.postStartdato = self.postStartdato!
            
            //AnsoegningViewController.callBack = { (status: String) in
             
                
                //only apply the blur if the user hasn't disabled transparency effects
               if !UIAccessibility.isReduceTransparencyEnabled {
                    //self.backgroundView.backgroundColor = .white

                    let blurEffect = UIBlurEffect(style: .light)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    //always fill the view
                    blurEffectView.frame = self.backgroundView.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    blurEffectView.tag = 1
                   
                   self.backgroundView.addSubview(blurEffectView)
                   
                    
                } else {
                    self.backgroundView.backgroundColor = .black
                }
                
                self.scrollView.setContentOffset(CGPointMake(0.0, 0.0), animated: false)
                
                // successpopup
                self.successPopUp.layer.cornerRadius = 24
                self.successPopUp.isHidden = false
                self.ansoegButton.isHidden = true
            }
        }
        
        /*if let vc = storyboard?.instantiateViewController(withIdentifier: "AnsoegningViewController")as? AnsoegningViewController {
            vc.callBack = { (status: String) in
                print(status)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }*/
        
    //}


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuBtn(menuBtn)
        
        successPopUp.isHidden = true
        
        view.insetsLayoutMarginsFromSafeArea = false
        
        
        singleTitelLabel.text = post?.titel
        beskrivelseLabel.text = post?.beskrivelse
        virksomhedsnavnLabel.text = post?.virksomhedsnavn
        telefonLabel.text = post?.telefon
        emailLabel.text = post?.email
        adresseLabel.text = post?.adresse_1
        postnrLabel.text = post?.post_nr
        byLabel.text = post?.by
        //ansoegButton.tag = post!.id!
        
        headerByLabel.text = post?.by
        headerVarighedLabel.text = post?.varighed
        //headerStartdatoLabel.text = post?.start_dato

        
        
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
    
    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
