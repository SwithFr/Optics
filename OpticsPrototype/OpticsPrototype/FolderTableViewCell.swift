//
//  FolderTableViewCell.swift
//  OpticsPrototype
//
//  Created by Jérémy Smith on 04/11/2015.
//  Copyright © 2015 Jérémy Smith. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var picturesCount: UILabel!
    @IBOutlet weak var participantsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
