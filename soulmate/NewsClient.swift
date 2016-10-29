//
//  NewsClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/22/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

enum News: Endpoint
{
    case Current(token: String)
    
    var request: NSURLRequest
    {
        
        let url = NSURL(string: "https://access.alchemyapi.com/calls/data/GetNews?apikey=0c946bde49878224025230853ec995cc1693dc3e&return=enriched.url.title,enriched.url.url&start=1473897600&end=1474585200&q.enriched.url.cleanedTitle=charlotte&q.enriched.url.enrichedTitle.docSentiment.type=negative&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=society&count=25&outputMode=json")
        return NSURLRequest(URL: url!)
        
        
     
    }
}

final class NewsAPIClient: APIClient
{
    // 
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
    
    convenience init(APIKey: String)
    {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration(), APIKey: APIKey)
    }
    
    
    func fetchCurrentNews(completion: APIResult <NewsInformation> -> Void)
    {
        let request = News.Current(token: self.token).request
        
        
        fetch(request, parse: { json -> NewsInformation? in
            
            //print("---Fetching---")
            //print(json)
            //print("---End---")
            print("---Parsing---")
            if let currentNewsDictionary = json["result"]! as? [String : AnyObject]
            {
                print("---currentNewsDictionary---")
                print(currentNewsDictionary["docs"])
                print("---End---")
                /*
                if let object = currentNewsDictionary["docs"]! as?  [String : AnyObject]
                {
                    for article in object
                    {
                        print(article)
                    }
                    
                }
 
                */
                for article in (currentNewsDictionary["docs"]! as? [String : AnyObject])!
                {
                    print("---ARTICLE---")
                    print(article)
                    print("--- ---")
                }
                return NewsInformation(JSON: currentNewsDictionary)!
            }
            else
            {
                return nil
            }
            
        }, completion: completion)
    }
    
}
