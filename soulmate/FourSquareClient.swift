//
//  FourSquareClient.swift
//  soulmate
//
//  Created by Richard Hsu on 11/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

enum FourSquare : FourSquareEndpoint
{
    // search endpoint
    case Venues(VenueEndpoint)
    
    enum VenueEndpoint : FourSquareEndpoint
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
        
        
        // MARK: Venue Endpoint - FourSquareEdpoint
        var baseURL: String
        {
            return "http://api.foursquare.com"
        }
        
        
        var path: String
        {
            switch self
            {
                case .Search: return "/v2/venues/search"
            }
        }
        
        private struct ParameterKeys
        {
            static let clientID = "client_id"
            static let clientSecret = "client_secret"
            static let version = "v"
            static let category = "categoryId"
            static let location = "ll"
            static let query = "query"
            static let limit = "limit"
            static let searchRadius = "radius"
        }
        
        private struct DefaultValues
        {
            static let version = "20160301"
            static let limit = "50"
            static let searchRadius = "2000"
        }
        
        var parameters: [String : AnyObject]
        {
            switch self
            {
                case .Search(let clientID, let clientSecret, let coordinate, let category, let query, let searchRadius, let limit):
                
                    var parameters: [String : AnyObject] = [
                    
                        ParameterKeys.clientID : clientID,
                        ParameterKeys.clientSecret : clientSecret,
                        ParameterKeys.version : DefaultValues.version,
                        ParameterKeys.location : coordinate.description,
                        ParameterKeys.category : category.description
    
                    ]
                    
                    if let searchRadius = searchRadius
                    {
                        parameters[ParameterKeys.searchRadius] = searchRadius
                    }
                    else
                    {
                        parameters[ParameterKeys.searchRadius] = DefaultValues.searchRadius
                    }
                    
                    if let limit = limit
                    {
                        parameters[ParameterKeys.limit] = limit
                    }
                    else
                    {
                        parameters[ParameterKeys.limit] = DefaultValues.limit
                    }
                    
                    if let query = query
                    {
                        parameters[ParameterKeys.query] = query
                    }
                    return parameters
            }
        }
        
        
    }
    
    
    // MARK: Foursquare - FourSquareEndpoint
    
    var baseURL: String
    {
        switch self
        {
            case .Venues(let endpoint):
                return endpoint.baseURL
        }
    }
    
    var path: String
    {
        switch self
        {
            case .Venues(let endpoint):
                return endpoint.path
        }
    }
    
    var parameters: [String : AnyObject]
    {
        switch self
        {
        case .Venues(let endpoint):
            return endpoint.parameters
        }
    }

}
