//
//  MessagesTableViewCell.swift
//  App Testing
//
//  Created by Betina Svendsen on 27/04/2023.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var beskedLabel: UILabel!
    
  /*  var postId: Int? = nil

    func configure(post: Ansoegning) {
        postId = post.id
        // configure the labels, etc in the cell
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
