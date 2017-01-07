//
//  SampleItemData.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import UIKit

class SampleItemData
{
    public var items : [Item]
    
    init() {
        items = [
            
            Item(name: "Sofa", description: "A foldable sofa bed", type: "Furniture", condition: "Used", price: 50.00, itemImage: UIImage(named: "sofa.png")!),
            Item(name: "Table", description: "A table able to be used for proper dining", type: "Furniture", condition: "Used", price: 25.00, itemImage: UIImage(named: "table.png")!)
            
        ]
        
        
    }
}
