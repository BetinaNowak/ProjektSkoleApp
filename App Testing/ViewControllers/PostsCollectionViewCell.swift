//
//  PostsCollectionViewCell.swift
//  App Testing
//
//  Created by Betina Svendsen on 24/03/2023.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    var PostsArray = [Opslag]()
    
    var imageView: UIImageView?
    var label: UILabel?
    


    override init(frame: CGRect) {
        super.init(frame: frame)
/*
        imageView = UIImageView(frame: self.bounds)
        //customise imageview
        imageView?.backgroundColor = UIColor.red
        contentView.addSubview(imageView!)
        label = UILabel(frame: CGRect(x: 20, y: 20, width: self.bounds.width - 20, height: 20))
        //Customsize label
        label?.text = "Hello"
        //label?.text = String(PostsArray[indexPath.row].titel!)
        label?.textColor = UIColor.white
        contentView.addSubview(label!)*/
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    
    
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
