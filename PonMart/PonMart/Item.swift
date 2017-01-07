//
//  Item.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation

class Item
{
    public var type : String
    public var condition : String
    public var price : Double
    
    init(type : String, condition : String, price : Double) {
        
        self.type = type
        self.condition = condition
        self.price = price
    }
}
