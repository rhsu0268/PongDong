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
    // search endpoint
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
                case Asian = "4bf58dd8d48988d142941735"
            }
            
            var description: String
            {
                switch self
                {
                    case .Food(let categories):
                        if let categories = categories
                        {
                            let commaSeparatedString = categories.reduce("") { categoryString, category in
                                "\(categoryString),\(category.rawValue)"
                            
                            }
                            return commaSeparatedString.substringFromIndex(commaSeparatedString.startIndex.advancedBy(1))
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
