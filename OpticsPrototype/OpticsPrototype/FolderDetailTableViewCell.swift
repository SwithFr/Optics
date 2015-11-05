//
//  FolderDetailTableViewCell.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 05/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FolderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
