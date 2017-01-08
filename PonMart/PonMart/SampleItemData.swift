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
            
            Item(name: "Sofa", description: "A foldable sofa bed", type: "Furniture", condition: "Used", price: 50.00, itemImage: UIImage(named: "sofa.jpeg")!),
            Item(name: "Table", description: "A table able to be used for proper dining", type: "Furniture", condition: "Used", price: 25.00, itemImage: UIImage(named: "sofa.jpeg")!),
            Item(name: "Chair", description: "A chair for the dining room", type: "Furniture", condition: "Used", price: 6.00, itemImage: UIImage(named: "sofa.jpeg")!),
            Item(name: "Bed", description: "A single person bed", type: "Furniture", condition: "Used", price: 17.00, itemImage: UIImage(named: "sofa.jpeg")!),
            Item(name: "Computer Chair", description: "A chair for the computer desk", type: "Furniture", condition: "Used", price: 12.00, itemImage: UIImage(named: "sofa.jpeg")!)
            
        ]
        
        
    }
}
