//
//  UserItemCell.swift
//  PonMart
//
//  Created by Richard Hsu on 2/12/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class UserItemCell: UITableViewCell {

    
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCondition: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemType: UILabel!
    @IBOutlet var itemDescription: UILabel!
    @IBOutlet var itemStatus: UILabel!

    
    
    @IBOutlet var itemImage: UIImageView!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
