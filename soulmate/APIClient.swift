//
//  APIClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/5/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

public let RCHNetworkingErrorDomain = "com.rch.soleLife.NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

typealias JSON = [String : AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask


enum APIResult<T>
{
    case Success(T)
    case Failure(ErrorType)
    
    
}

protocol Endpoint
{
    var baseURL: NSURL
    {
        get
    }
    var path: String
    {
        get
    }
    var request: NSURLRequest
    {
        get
    }
}

protocol APIClient
{
    var configuration: NSURLSessionConfiguration
    {
        get
    }
    
    var session: NSURLSession
    {
        get
    }
    
    init(config: NSURLSessionConfiguration)
    
    // three parameters: optional dictionary, object (NSHTTPURLResponse), option alNSErrro object
    // return type is Void
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    
    // take a function of type JSON and convert it to T
    
    // take JSON returned from the handler and convert it to any model instance
    
    // 2nd closure:
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult <T> -> Void)

}

extension APIClient
{
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    {
        // create a task
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            
            // guard statement
            // let - force cast
            guard let HTTPResponse = response as? NSHTTPURLResponse
                
            else
            {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: RCHNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                
                completion(nil, nil, error)
                
                // transfers control and hands it to JSONTaskWithRequest
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
                // convert data to JSON object and return it
                switch HTTPResponse.statusCode
                {
                    case 200:
                        do
                        {
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
                            completion(json, HTTPResponse, nil)
                        }
                        catch let error as NSError
                        {
                            completion(nil, HTTPResponse, error)
                        }
                    
                    default: print("Recieved HTTP Response: \(HTTPResponse.statusCode) - not handled")
                    
                    
                }
            }
            
            
        }
        return task
        // convert data to JSONdata
        
    }
    
    
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult <T> -> Void)
    {
        // make a request with a JSON object
        let task = JSONTaskWithRequest(request)
        {
            json, response, error in
            
            guard let json = json else
            {
                if let error = error
                {
                    completion(.Failure(error))
                }
                else
                {
                    // TODO: Implement Error Hnadling
                    
                }
                return
            }
            
            if let value = parse(json)
            {
                completion(.Success(value))
            }
            else
            {
                let error = NSError(domain: RCHNetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                completion(.Failure(error))
            }
            
        }
        
        // start the task
        task.resume()
    }
}
