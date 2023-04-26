//
//  AllInternshipsTableViewCell.swift
//  App Testing
//
//  Created by Betina Svendsen on 28/03/2023.
//

import UIKit

class AllInternshipsTableViewCell: UITableViewCell {

    //var PostsArray = [Opslag]()
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var internshipImageView: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var beskrivelseLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var varighedLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    weak var delegate: CustomCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    
    func configure(text: String, delegate: CustomCellDelegate) {
            //titelLabel.text = text
            self.delegate = delegate
        }

        @IBAction func didTapButton(_ button: UIButton) {
            delegate?.cell(self, didTap: button)
        }


}

protocol CustomCellDelegate: AnyObject {
    func cell(_ cell: AllInternshipsTableViewCell, didTap button: UIButton)
}
