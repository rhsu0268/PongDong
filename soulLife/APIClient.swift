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


enum APIResult<T>
{
    case success(T)
    case failure(Error)
}


protocol APIClient
{
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWithRequest(_ request: URLRequest, completion: @escaping JSONCompletion) -> JSONTask
    
}

extension APIClient

{
    func JSONTaskWithRequest(_ request: URLRequest, completion: @escaping JSONCompletion) -> JSONTask
    {
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: soulLifeNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                return
                
                
            }
            
            
            if data == nil
            {
                if let error = error
                {
                    completion(nil, HTTPResponse, error as NSError?)
                }
            }
            else
            {
                switch HTTPResponse.statusCode
                {
                    case 200:
                        do
                        {
                            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                            completion(json, HTTPResponse, nil)
                            
                        }
                        catch let error as NSError
                        {
                            completion(nil, HTTPResponse, error)
                        }
                    default:
                        print("Recieved HTTP response: \(HTTPResponse.statusCode), which was not handled!")
                }
            }
            
            
        })
        return task
    }
    
    
    func fetch<T>(_ request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping
    (APIResult<T>) -> Void)
    {
        let task = JSONTaskWithRequest(request) { json, response, error in
            
            DispatchQueue.main.async
            {
                guard let json = json else
                {
                    if let error = error
                    {
                        completion(.failure(error))
                    }
                    else
                    {
                        
                    }
                    return
                }
                
                if let resource = parse(json)
                {
                    completion(.success(resource))
                }
                else
                {
                    let error = NSError(domain: soulLifeNetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    

}























