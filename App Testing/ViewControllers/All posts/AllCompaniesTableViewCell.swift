//
//  AllCompaniesTableViewCell.swift
//  App Testing
//
//  Created by mediastyle on 06/06/2023.
//

import Foundation

import UIKit

class AllCompaniesTableViewCell: UITableViewCell {

    
    var CompaniesArray = [Virksomhed]()

    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var companyImageView: UIImageView!
    
    @IBOutlet weak var navnLabel: UILabel!
    
    @IBOutlet weak var kortBeskrivelseLabel: UILabel!
    
    @IBOutlet weak var adresseLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    //@IBOutlet weak var saveBtn: UIButton!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
