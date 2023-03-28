//
//  AllInternshipsViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 28/03/2023.
//

import UIKit

class AllInternshipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var internshipsTableView: UITableView!
    

    var PostsArray = [Opslag]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkServicePosts.sharedObj.getPosts { (Opslag) in
            self.PostsArray = Opslag
            self.internshipsTableView.reloadData()
        }
        
        internshipsTableView.delegate = self
        internshipsTableView.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllInternshipsTableViewCell
        
        cell.titelLabel.text = PostsArray[indexPath.row].titel
        cell.beskrivelseLabel.text = PostsArray[indexPath.row].beskrivelse
        cell.varighedLabel.text = PostsArray[indexPath.row].varighed
        cell.byLabel.text = PostsArray[indexPath.row].by
        
        
        let image: Opslag
        image = PostsArray[indexPath.row]
        let string = "http://test-postnord.dk" + (image.cover_billede!)
        let url = URL(string: string)
        cell.internshipImageView.downloadedimg(from: url!, contentMode: .scaleAspectFill )
        
        cell.cellView.layer.cornerRadius = 10
        
        cell.internshipImageView.round(corners: [.topLeft,.bottomLeft], radius: 10, borderColor: .clear, borderWidth: 0)
        
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.3
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowPath = UIBezierPath(roundedRect: cell.cellView.bounds, cornerRadius: 10).cgPath
        
        
        return cell
    }

}


extension UIView
{

   @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    return mask
   }

func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
    let borderLayer = CAShapeLayer()
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.addSublayer(borderLayer)
}

func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
    let mask = _round(corners: corners, radius: radius)
    addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
}
}



extension UIImageView {
    func downloadedimg(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloadedimg(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
