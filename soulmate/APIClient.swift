//
//  APIClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/5/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

typealias JSON = [String : AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask


enum APIResult<T>
{
    case Success(T)
    case Failure(ErrorType)
    
    
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
