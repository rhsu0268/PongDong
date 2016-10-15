//
//  ForecastClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/11/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation
/*
struct Coordinate
{
    let latitude: Double
    let longitude: Double
    
}

enum Forecast: Endpoint
{
    case Current(token: String, coordinate: Coordinate)
    
    var baseURL: NSURL
    {
        return NSURL(string: "https://api.forecast.io")!
    }
    
    var path: String
    {
        switch self
        {
            case .Current(let  token, let coordinate):
                return "/forecast/\(token)/\(coordinate.latitude),\(coordinate.longitude)"
        }
    }
    
    var request: NSURLRequest
    {
        let url = NSURL(string: path, relativeToURL: baseURL)!
        return NSURLRequest(URL: url)
    }
    
}

final class NewsClient: APIClient
{
    // create methods that interact with the forecast api
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    
    private let token: String
    
    init(config: NSURLSessionConfiguration, APIKey: String)
    {
        self.configuration = config
        self.token = APIKey
    }
    
    // convenience init
    convenience init(APIKey: String)
    {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration(),
                  APIKey: APIKey)
        
    }
    
    // fetch news 
    func fetchCurrentWeather(coordinate: Coordinate, completion: APIResult<NewsInformation> -> Void)
    {
        let request = Forecast.Current(token: self.token, coordinate: coordinate).request
        
        
        fetch(request, parse: { json -> NewsInformation? in
            
            // Parse from JSON response to NewsInformation
            if let currentNewsDictionary = json["results"] as? [String: AnyObject]
            {
                return NewsInformation(JSON: currentNewsDictionary)
                
            }
            else
            {
                return nil
            }
        }, completion: completion)
 
    }
    
    
    
    
    
}
*/

