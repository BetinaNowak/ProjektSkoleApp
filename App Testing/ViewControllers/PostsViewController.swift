//
//  PostsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import UIKit

class PostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var PostsArray = [Opslag]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postsCollectionView.register(PostsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.addSubview(postsCollectionView)
        
        NetworkServicePosts.sharedObj.getPosts { (Opslag) in
            self.PostsArray = Opslag
            self.postsCollectionView.reloadData()
        }
        
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
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
        return PostsArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostsCollectionViewCell
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
        
            let imgUrl = "http://test-postnord.dk" + (PostsArray[indexPath.row].cover_billede!)
            imageView.downloadedFrom(from: imgUrl)
    

            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
        
        // Shadow
        imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 7.0
        
        
            cell.contentView.addSubview(imageView)
        
        
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 100))
            title.text = String(PostsArray[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 16)
            title.textColor = UIColor.white
            title.textAlignment = .center
            title.contentMode = .scaleAspectFit
            cell.contentView.addSubview(title)
        

        
        return cell
    }
}







extension UIImageView {
    func downloadedFrom(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadedFrom(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}