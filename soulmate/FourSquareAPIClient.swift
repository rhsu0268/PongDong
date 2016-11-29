//
//  FourSquareAPIClient.swift
//  soulmate
//
//  Created by Richard Hsu on 11/28/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

public let FTRENetworkingErrorDomain = "com.richardhsu.Soulmate.NetworkingError"
public let FMissingHttpResponseError: Int = 10
public let FUnexpectedResponseError: Int = 20



typealias FJSON = [String : AnyObject]
typealias FJSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias FJSONTask = NSURLSessionDataTask

enum FourSquareAPIResult<T>
{
    case Success(T)
    case Failure(ErrorType)
}

protocol FourSquareJSONDecodable
{
    init?(JSON: [String : AnyObject])
}

protocol FourSquareEndpoint
{
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: AnyObject] { get }
    
}


extension FourSquareEndpoint
{
    var queryComponents: [NSURLQueryItem]
    {
        var components = [NSURLQueryItem]()
        
        for (key, value) in parameters
        {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    
    var request: NSURLRequest
    {
        let components = NSURLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        
        
        //components.percentEncodedQuery
        
        let url = components.URL!
        
        return NSURLRequest(URL: url)
    }
}

protocol FourSquareAPIClient
{
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    func fetch<T: JSONDecodable>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult <T> -> Void)
    
}

extension FourSquareAPIClient
{
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    {
        let task = session.dataTaskWithRequest(request)
        {
            data, response, error in
            
            guard let HTTPResponse = response as? NSHTTPURLResponse else
            {
                let userInfo = [
                    
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                    
                ]
                
                let error = NSError(domain: TRENetworkingErrorDomain, code: MissingHttpResponseError, userInfo: userInfo)
                
                
                completion(nil, nil, error)
                
                return
            }
            
            if data == nil
            {
                if let error = error
                {
                    completion(nil, HTTPResponse, error)
                }
            }
            else
            {
                switch HTTPResponse.statusCode
                {
                case 200:
                    do
                    {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as?
                            [String : AnyObject]
                        completion(json, HTTPResponse, nil)
                    }
                    catch let error as NSError
                    {
                        completion(nil, HTTPResponse, error)
                    }
                default: print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
                }
            }
        }
        return task
    }
    
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult <T> -> Void)
    {
        let task = JSONTaskWithRequest(request)
        {
            json, response, error in
            
            //print("---")
            //print(json)
            //print("---")
            
            dispatch_async(dispatch_get_main_queue())
            {
                guard let json = json else
                {
                    if let error = error
                    {
                        completion(.Failure(error))
                    }
                    else
                    {
                        fatalError("Both json and error variables are set to nil")
                    }
                    return
                }
                
                if let value = parse(json)
                {
                    //print("---parsing---")
                    //print(value)
                    //print("---")
                    completion(.Success(value))
                }
                else
                {
                    let error = NSError(domain: TRENetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                    completion(.Failure(error))
                }
            }
        }
        task.resume()
    }
}
