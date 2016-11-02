//
//  FourSquareClient.swift
//  soulmate
//
//  Created by Richard Hsu on 11/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

enum FourSquare
{
    case Venues(VenueEndpoint)
    
    
    enum VenueEndpoint
    {
        case Search(clientID: String, clientSecret: String, coordinate: Coordinate, category: Category, query: String?, searchRadius: Int?, limit: Int?)
        
        
        
        enum Category
        {
            case Food([FoodCategory]?)
            
            enum FoodCategory: String
            {
                case Afghan = "503288ae91d4c4b30a586d67"
            }
            
            
            var description: String {
                
                switch self
                {
                    case .Food(let categories):
                        if let categories = categories
                        {
                            let commaSeperatedString = categories.reduce("") {
                                categoryString, category in "\(categoryString),\(category.rawValue)"
                                
                                
                            }
                            return commaSeperatedString.substringFromIndex(commaSeperatedString.startIndex.advancedBy(1))
                        }
                        else
                        {
                            return "4d4b7105d754a06374d81259"
                        }
                }
            }
            
            
        }
    }
}
