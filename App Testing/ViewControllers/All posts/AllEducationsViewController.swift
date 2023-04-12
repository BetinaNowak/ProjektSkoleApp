//
//  AllEducationsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 29/03/2023.
//

import UIKit

class AllEducationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var educationsTableView: UITableView!
    
    var PostsArray = [Opslag]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkServicePostsEducation.sharedObj.getEducationPosts { (Opslag) in
            self.PostsArray = Opslag
            self.educationsTableView.reloadData()
        }
        
        educationsTableView.delegate = self
        educationsTableView.dataSource = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.black

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
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllEducationsTableViewCell
        
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
    


