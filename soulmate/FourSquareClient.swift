//
//  FourSquareClient.swift
//  soulmate
//
//  Created by Richard Hsu on 11/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

enum FourSquare: Endpoint
{
    case Venues(VenueEndpoint)
    
    
    enum VenueEndpoint
    {
        case Search(clientID: String, clientSecret: String, coordinate: Coordinate)
        
        
        
        enum Category
        {
            case Food([FoodCategory]?)
            
            enum FoodCategory: String
            {
                case Afghan = "503288ae91d4c4b30a586d67"
            }
            
            
        }
    }
}
