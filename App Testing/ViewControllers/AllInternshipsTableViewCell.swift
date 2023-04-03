//
//  AllInternshipsTableViewCell.swift
//  App Testing
//
//  Created by Betina Svendsen on 28/03/2023.
//

import UIKit

class AllInternshipsTableViewCell: UITableViewCell {
    
    
    var PostsArray = [Opslag]()

    
    @IBOutlet weak var cellView: UIView!
    
    
    @IBOutlet weak var internshipImageView: UIImageView!
    
    
    @IBOutlet weak var titelLabel: UILabel!
    
    
    @IBOutlet weak var beskrivelseLabel: UILabel!
    
    
    @IBOutlet weak var byLabel: UILabel!
    
    @IBOutlet weak var varighedLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
