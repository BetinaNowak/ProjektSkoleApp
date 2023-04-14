//
//  AllEducationsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 29/03/2023.
//

import UIKit

class AllEducationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchControllerDelegate {

    
    @IBOutlet weak var educationsTableView: UITableView!
    
    
    @IBOutlet weak var phoneSearchView: UIView!
    
    @IBOutlet weak var searchBarContainer: UIView!
    
    
    var PostsArray = [Opslag]()
    
    var searchResultController = UISearchController(searchResultsController: nil)
    
    var filteredPosts: [Opslag] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkServicePostsEducation.sharedObj.getEducationPosts { (Opslag) in
            self.PostsArray = Opslag
            self.educationsTableView.reloadData()
        }
        
        educationsTableView.delegate = self
        educationsTableView.dataSource = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.black

        // Search
        searchResultController.searchBar.delegate = self
        view.addSubview(searchBarContainer)
        self.setupSearchController()
        
        
        // Create TapGestureRecognizer that dismisses keyboard on tap outside searchbar
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
        
    }
    
    // Function for dismissing keyboard on tap outside searchbar
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchResultController.searchBar.resignFirstResponder()
        
        self.phoneSearchView.addSubview(self.searchResultController.searchBar)
        self.educationsTableView.tableHeaderView = self.phoneSearchView
        self.searchResultController.searchBar.showsCancelButton = false
        
    }
    
    
    // Function for setting up the search bar
    func setupSearchController() {

        self.searchResultController.searchResultsUpdater = self
        self.searchResultController.delegate = self
        self.searchResultController.hidesNavigationBarDuringPresentation = false
        self.searchResultController.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchResultController.searchBar.placeholder = "Søg.."
        self.searchResultController.searchBar.delegate = self
        self.searchResultController.searchBar.searchBarStyle = .minimal
        self.searchResultController.searchBar.tintColor = UIColor.white
        
        self.phoneSearchView.addSubview(self.searchResultController.searchBar)
        self.educationsTableView.tableHeaderView = self.phoneSearchView
        
        //self.searchResultController.navigationItem.searchController = searchResultController
    
        //self.searchResultController.searchBar.showsCancelButton = false
        definesPresentationContext = true
        
    }

    
    
    // Add searchbar to view
    override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()
        self.searchResultController.searchBar.sizeToFit()
        self.searchResultController.searchBar.frame.size.width = self.phoneSearchView.frame.size.width
        self.searchResultController.searchBar.frame.size.height = self.phoneSearchView.frame.size.height

    }
    
    // When search cancel button is clicked reload tableview
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
            filteredPosts = PostsArray
        educationsTableView.reloadData()
        }
    
    // Filter out the posts whose titles do not match the typed in search text
    private func filterPosts(for searchText: String) {
      filteredPosts = PostsArray.filter { post in
        return
          post.titel!.lowercased().contains(searchText.lowercased())
      }
        educationsTableView.reloadData()
    }

    
    override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        if let destination = seque.destination as? SinglePostViewController {
            destination.post = PostsArray[educationsTableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPost", sender: self)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If searching show filtered posts, else show all
        if searchResultController.isActive && searchResultController.searchBar.text != "" {
            return filteredPosts.count
        }
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllEducationsTableViewCell
        
        
        let post: Opslag // error occurs even though the value 'post' is used below?
        
        // If search is active, show the filtered post in row
        if searchResultController.isActive && searchResultController.searchBar.text != "" {
            post = filteredPosts[indexPath.row]
        } else {
            post = PostsArray[indexPath.row]
        }
        
        
        
        cell.titelLabel.text = PostsArray[indexPath.row].titel
        cell.beskrivelseLabel.text = PostsArray[indexPath.row].beskrivelse
        cell.varighedLabel.text = PostsArray[indexPath.row].varighed
        cell.byLabel.text = PostsArray[indexPath.row].by
        
        let imgUrl = "http://test-postnord.dk" + (PostsArray[indexPath.row].cover_billede!)
        cell.educationImageView.downloadimg(from: imgUrl, contentMode: .scaleAspectFill)
        
        
        // Image styling
        cell.educationImageView.rounded(corners: [.topLeft,.bottomLeft], radius: 10, borderColor: .clear, borderWidth: 0)
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.3
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowPath = UIBezierPath(roundedRect: cell.cellView.bounds, cornerRadius: 10).cgPath
        
        
        return cell
    }
    

}


// Make it possible to round selected corners
extension UIView
{

   @discardableResult func _rounded(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    return mask
   }

func addBorders(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
    let borderLayer = CAShapeLayer()
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.addSublayer(borderLayer)
}

func rounded(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
    let mask = _rounded(corners: corners, radius: radius)
    addBorders(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
}
}


// Load images
extension UIImageView {
    func downloadimg(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadimg(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
    

// Update search results
extension AllEducationsViewController: UISearchResultsUpdating {

       func updateSearchResults(for searchController: UISearchController) {
         filterPosts(for: searchController.searchBar.text ?? "")
       }
  
}
