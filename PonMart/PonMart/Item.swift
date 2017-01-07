//
//  Item.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import UIKit

class Item
{
    public var name : String
    public var description : String
    public var type : String
    public var condition : String
    public var price : Double
    public var itemImage : UIImage
    
    init(name : String, description : String, type : String, condition : String, price : Double, itemImage : UIImage) {
        
        self.name = name
        self.description = description
        self.type = type
        self.condition = condition
        self.price = price
        self.itemImage = itemImage
        
    }
}
