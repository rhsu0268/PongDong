//
//  UserItem.swift
//  PonMart
//
//  Created by Richard Hsu on 2/15/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation

class UserItem
{
    public var itemName : String
    public var itemCategory : String
    public var itemCondition : String
    public var itemDescription : String
    public var itemPrice : Double
    public var itemImageUrl : String
    public var createdDate : String
    public var updatedDate : String 
    public var publicOrPrivate : BooleanLiteralType
    public var itemId : String
    public var userItemId : String
    
    public var itemSold : Bool
    
    init()
    {
        itemName = ""
        itemCategory = ""
        itemCondition = ""
        itemDescription = ""
        itemPrice = 0
        itemImageUrl = ""
        createdDate = ""
        updatedDate = ""
        itemId = ""
        publicOrPrivate = false
        userItemId = ""
        itemSold = false
        
    }
    
}
