//
//  ForecastClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/11/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation


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
    
    
}


