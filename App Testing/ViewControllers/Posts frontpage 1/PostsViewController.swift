//
//  PostsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import UIKit

class PostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var postsCollectionView1: UICollectionView!
    @IBOutlet weak var postsCollectionView2: UICollectionView!
    
    
    var PostsArray = [Opslag]()

    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        postsCollectionView2.register(PostsCollectionViewCells2.self, forCellWithReuseIdentifier: "cell2")
         view.addSubview(postsCollectionView2)
        
        postsCollectionView1.register(PostsCollectionViewCells1.self, forCellWithReuseIdentifier: "cell1")
         view.addSubview(postsCollectionView1)
        
        // Fetch internship posts
        NetworkServicePostsInternship.sharedObj.getInternshipPosts { (Opslag) in
            self.PostsArray = Opslag
            self.postsCollectionView1.reloadData()
        }
        
        // Fetch education posts
        NetworkServicePostsEducation.sharedObj.getEducationPosts { (Opslag) in
            self.PostsArray = Opslag
            self.postsCollectionView2.reloadData()
        }
        
        postsCollectionView1.delegate = self
        postsCollectionView1.dataSource = self
        
        postsCollectionView2.delegate = self
        postsCollectionView2.dataSource = self
        
        //self.navigationController?.navigationBar.tintColor = UIColor.black
        
    
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
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPost = PostsArray[indexPath.item]
        
        performSegue(withIdentifier: "showPost", sender: selectedPost)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.postsCollectionView1 {
            return PostsArray.count
            
        } else {
            return PostsArray.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            
        if collectionView == self.postsCollectionView1 {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PostsCollectionViewCells1
            
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell1.bounds.size.width, height: cell1.bounds.size.height))
            
            // Image view
            let imgUrl = "http://test-postnord.dk" + (PostsArray[indexPath.row].cover_billede!)
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
            title.text = String(PostsArray[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 15)
            title.textColor = UIColor.white
            title.textAlignment = .left
            title.contentMode = .scaleAspectFit
            cell1.contentView.addSubview(title)
            
            
            // Location
            let location = UILabel(frame: CGRect(x: 35, y: 125, width: cell1.bounds.size.width, height: 20))
            location.text = String(PostsArray[indexPath.row].by!)
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
            duration.text = String(PostsArray[indexPath.row].varighed!)
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
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! PostsCollectionViewCells2
            
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell2.bounds.size.width, height: cell2.bounds.size.height))
            
            // Image view
            let imgUrl = "http://test-postnord.dk" + (PostsArray[indexPath.row].cover_billede!)
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
            title.text = String(PostsArray[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 15)
            title.textColor = UIColor.white
            title.textAlignment = .left
            title.contentMode = .scaleAspectFit
            cell2.contentView.addSubview(title)
            
            
            // Location
            let location = UILabel(frame: CGRect(x: 35, y: 125, width: cell2.bounds.size.width, height: 20))
            location.text = String(PostsArray[indexPath.row].by!)
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
            duration.text = String(PostsArray[indexPath.row].varighed!)
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
    func downloadedFrom(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
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
    func downloadedFrom(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


