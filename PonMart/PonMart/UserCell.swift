//
//  User.swift
//  PonMart
//
//  Created by Richard Hsu on 2/23/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit


class UserCell: UITableViewCell {

    
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
