//
//  PostsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 23/03/2023.
//

import UIKit
import SDWebImage

class PostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    
    
    var PostsArray = [Opslag]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postsCollectionView.register(PostsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.addSubview(postsCollectionView)
        
        
        downloadJSON() {
            self.postsCollectionView.reloadData()
            print("succes")
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
        
        
        /*if let desination = segue.destination as? SinglePostViewController {
            desination.post = PostsArray[collectionView.indexPathsForSelectedItems.item]*/
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
        cell.backgroundColor = UIColor.red
        
        
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
            title.text = String(PostsArray[indexPath.row].titel!)
            title.font = UIFont(name: "AvenirNext-Bold", size: 15)
            title.textAlignment = .center
            cell.contentView.addSubview(title)
        
        
        return cell
    }
    
    

    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPost", sender: self)
        /*
         let selectedPost = PostsArray[indexPath.item]
         print(selectedPost)
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? SinglePostViewController {
            desination.post = PostsArray[collectionView.indexPathsForSelectedItems.item]
        }
    }*/
    

    
    func downloadJSON(completed: @escaping() -> ()) {
        let url = URL(string: "http://test-postnord.dk/api-get-opslag.php")
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {
                    self.PostsArray = try JSONDecoder().decode([Opslag].self, from: data!)
                }
                catch {
                    print("Error fetching data")
                }
                
                DispatchQueue.main.async {
                    completed()
                }
            }
        }.resume()
    }
    

}
