//
//  PublicItem.swift
//  PonMart
//
//  Created by Richard Hsu on 2/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import UIKit

class PublicItem : NSObject
{
    public var name : String
    public var itemDescription : String
    public var type : String
    public var condition : String
    public var price : Double
    public var itemImageUrl : String
    public var userId : String
    public var createdDate : String
    
 
    /*
    init(name : String, description : String, type : String, condition : String, price : Double, itemImage : String, userId : String) {
        
        self.name = name
        self.description = description
        self.type = type
        self.condition = condition
        self.price = price
        self.itemImageUrl = itemImage
        self.userId = userId
        
    }
    */
    
    override init()
    {
        name = ""
        itemDescription = ""
        type = ""
        condition = ""
        price = 0
        itemImageUrl = ""
        userId = ""
        createdDate = ""

    }

}
