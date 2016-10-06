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

}
