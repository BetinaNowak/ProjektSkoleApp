//
//  PostsViewController2.swift
//  App Testing
//
//  Created by Betina Svendsen on 27/03/2023.
//

import UIKit

class PostsViewController2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var postsCollectionView1: UICollectionView!
    @IBOutlet weak var postsCollectionView2: UICollectionView!
    
    var PostsArray1 = [Opslag]()
    var PostsArray2 = [Opslag]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        postsCollectionView2.register(PostsCollectionViewCell2.self, forCellWithReuseIdentifier: "cell2")
         view.addSubview(postsCollectionView2)
        
        postsCollectionView1.register(PostsCollectionViewCell1.self, forCellWithReuseIdentifier: "cell1")
         view.addSubview(postsCollectionView1)
        
        // Fetch internship posts
        NetworkServicePostsInternship.sharedObj.getInternshipPosts { (Opslag) in
            self.PostsArray1 = Opslag
            self.postsCollectionView1.reloadData()
        }
        
        // Fetch education posts
        NetworkServicePostsEducation.sharedObj.getEducationPosts { (Opslag) in
            self.PostsArray2 = Opslag
            self.postsCollectionView2.reloadData()
        }
        
        postsCollectionView1.delegate = self
        postsCollectionView1.dataSource = self
        
        postsCollectionView2.delegate = self
        postsCollectionView2.dataSource = self
        
        
        setMenuBtn(menuBtn)
        
    }
    
    
    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? Opslag else {
            return
        }
        
        if segue.identifier == "showPost" {
            guard let destinationVC = segue.destination as?
                    SinglePostViewController else {
                return
            }
            
            destinationVC.post = selectedItem
        }
        
        if segue.identifier == "showEducation" {
            guard let destinationVC = segue.destination as?
                    SingleEducationViewController else {
                return
            }
            
            destinationVC.post = selectedItem
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.postsCollectionView1 {
            let selectedPost = PostsArray1[indexPath.item]
            
            if selectedPost.opslag_type == "praktik" {
                performSegue(withIdentifier: "showPost", sender: selectedPost)
            } else if selectedPost.opslag_type == "uddannelse" {
                performSegue(withIdentifier: "showEducation", sender: selectedPost)
            }
            
            
        } else {
            let selectedPost = PostsArray2[indexPath.item]
            
            if selectedPost.opslag_type == "praktik" {
                performSegue(withIdentifier: "showPost", sender: selectedPost)
            } else if selectedPost.opslag_type == "uddannelse" {
                performSegue(withIdentifier: "showEducation", sender: selectedPost)
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return PostsArray.count
        
        if collectionView == self.postsCollectionView1 {
            return PostsArray1.count
            
        } else {
            return PostsArray2.count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.postsCollectionView1 {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PostsCollectionViewCell1
            
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell1.bounds.size.width, height: cell1.bounds.size.height))
            
            // Image view
            let imgUrl = "http://test-postnord.dk" + (PostsArray1[indexPath.row].cover_billede!)
            imageView.downloaded(from: imgUrl)
            
            
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            
            // Shadow
            imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
            imageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            imageView.layer.shadowOpacity = 0.5
            imageView.layer.shadowRadius = 7.0
            
            cell1.contentView.addSubview(imageView)
            
            
            // Blur effect
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            //visualEffectView.contentMode = .scaleAspectFill
            visualEffectView.frame = CGRect(x: 8, y: 75, width: 183, height: 100)
            visualEffectView.layer.cornerRadius = 10.0
            visualEffectView.clipsToBounds = true
            imageView.addSubview(visualEffectView)
            
            
            // Title
            let title = UILabel(frame: CGRect(x: 15, y: 85, width: cell1.bounds.size.width, height: 20))
            title.text = String(PostsArray1[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 15)
            title.textColor = UIColor.white
            title.textAlignment = .left
            title.contentMode = .scaleAspectFit
            cell1.contentView.addSubview(title)
            
            
            // Location
            let location = UILabel(frame: CGRect(x: 35, y: 125, width: cell1.bounds.size.width, height: 20))
            location.text = String(PostsArray1[indexPath.row].by!)
            location.font = UIFont(name: "AvenirNext-Bold", size: 14)
            location.textColor = UIColor.white
            location.textAlignment = .left
            location.contentMode = .scaleAspectFit
            cell1.contentView.addSubview(location)
            
            // Location icon
            let locationImageView = UIImageView(frame: CGRect(x: -20, y: 2, width: 15, height: 15))
            locationImageView.image = UIImage(systemName: "mappin.circle.fill")
            location.addSubview(locationImageView)
            locationImageView.translatesAutoresizingMaskIntoConstraints = false
            
            
            // Duration
            let duration = UILabel(frame: CGRect(x: 35, y: 150, width: cell1.bounds.size.width, height: 20))
            duration.text = String(PostsArray1[indexPath.row].varighed!)
            duration.font = UIFont(name: "AvenirNext-Bold", size: 14)
            duration.textColor = UIColor.white
            duration.textAlignment = .left
            duration.contentMode = .scaleAspectFit
            cell1.contentView.addSubview(duration)
            
            // Duration icon
            let durationImageView = UIImageView(frame: CGRect(x: -20, y: 2, width: 15, height: 15))
            durationImageView.image = UIImage(systemName: "clock.fill")
            duration.addSubview(durationImageView)
            durationImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return cell1
            
        } else {
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! PostsCollectionViewCell2
            
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell2.bounds.size.width, height: cell2.bounds.size.height))
            
            // Image view
            let imgUrl = "http://test-postnord.dk" + (PostsArray2[indexPath.row].cover_billede!)
            imageView.downloaded(from: imgUrl)
            
            
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            
            // Shadow
            imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
            imageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            imageView.layer.shadowOpacity = 0.5
            imageView.layer.shadowRadius = 7.0
            
            cell2.contentView.addSubview(imageView)
            
            
            // Blur effect
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            //visualEffectView.contentMode = .scaleAspectFill
            visualEffectView.frame = CGRect(x: 8, y: 75, width: 183, height: 100)
            visualEffectView.layer.cornerRadius = 10.0
            visualEffectView.clipsToBounds = true
            imageView.addSubview(visualEffectView)
            
            
            // Title
            let title = UILabel(frame: CGRect(x: 15, y: 85, width: cell2.bounds.size.width, height: 20))
            title.text = String(PostsArray2[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 15)
            title.textColor = UIColor.white
            title.textAlignment = .left
            title.contentMode = .scaleAspectFit
            cell2.contentView.addSubview(title)
            
            
            // Location
            let location = UILabel(frame: CGRect(x: 35, y: 125, width: cell2.bounds.size.width, height: 20))
            location.text = String(PostsArray2[indexPath.row].by!)
            location.font = UIFont(name: "AvenirNext-Bold", size: 14)
            location.textColor = UIColor.white
            location.textAlignment = .left
            location.contentMode = .scaleAspectFit
            cell2.contentView.addSubview(location)
            
            // Location icon
            let locationImageView = UIImageView(frame: CGRect(x: -20, y: 2, width: 15, height: 15))
            locationImageView.image = UIImage(systemName: "mappin.circle.fill")
            location.addSubview(locationImageView)
            locationImageView.translatesAutoresizingMaskIntoConstraints = false
            
            
            // Duration
            let duration = UILabel(frame: CGRect(x: 35, y: 150, width: cell2.bounds.size.width, height: 20))
            duration.text = String(PostsArray2[indexPath.row].varighed!)
            duration.font = UIFont(name: "AvenirNext-Bold", size: 14)
            duration.textColor = UIColor.white
            duration.textAlignment = .left
            duration.contentMode = .scaleAspectFit
            cell2.contentView.addSubview(duration)
            
            // Duration icon
            let durationImageView = UIImageView(frame: CGRect(x: -20, y: 2, width: 15, height: 15))
            durationImageView.image = UIImage(systemName: "clock.fill")
            duration.addSubview(durationImageView)
            durationImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return cell2
            
            
        }
    }
}



extension UIImageView {
    func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
