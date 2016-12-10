//
//  APIClient.swift
//  soulLife
//
//  Created by Richard Hsu on 12/7/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation


public let soulLifeNetworkingErrorDomain = "com.souLife.NetworkingError"

public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

protocol JSONDecodable
{
    init?(JSON: [String : AnyObject])
}

protocol Endpoint
{
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String : AnyObject] { get }
}

extension Endpoint
{
    var queryComponents: [URLQueryItem]
    {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters
        {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    var request: URLRequest
    {
        var components = URLComponents(string: baseURL)!
        
        components.path = path
        components.queryItems = queryComponents
        
        
        let url = components.url!
        
        return URLRequest(url: url)
    }
}


typealias JSON = [String : AnyObject]
typealias JSONCompletion = (JSON?, HTTPURLResponse?, NSError?) -> Void
typealias JSONTask = URLSessionDataTask
