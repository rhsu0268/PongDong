//
//  ItemCell.swift
//  PonMart
//
//  Created by Richard Hsu on 1/8/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var conditionImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
