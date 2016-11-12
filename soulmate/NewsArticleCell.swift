//
//  NewsArticleCell.swift
//  soulmate
//
//  Created by Richard Hsu on 11/8/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit

class NewsArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var articleTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
