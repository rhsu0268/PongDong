//
//  NewsClient.swift
//  soulmate
//
//  Created by Richard Hsu on 10/22/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

var newsArticleDictionary = [NewsArticle]()

enum News: Endpoint
{
    case Current(token: String)
    
    var request: NSURLRequest
    {
        
        let url = NSURL(string: "https://newsapi.org/v1/articles?source=cnn&apiKey=d2ca6d7c23544c9fb982048fd0b1f6d7&category=general")
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
            if let currentNewsDictionary = json["articles"]! as? [AnyObject]
            {
                print("---currentNewsDictionary---")
                //print(currentNewsDictionary["docs"])
                print(currentNewsDictionary)
                print("---End---")
                
                
                for article in currentNewsDictionary
                {
                    let newsArticle = newsArticle(title: "", url: "")
                }
                
                //var title = ""
                //var url = ""
                
                // let object = currentNewsDictionary["docs"] as? [String: AnyObject]
                /*
                for article in (currentNewsDictionary["docs"] as? [AnyObject])!
                {
                    //print(article)
                    
                    // create a new NewsArticle object
                    let newsArticle = NewsArticle(title: "", url: "")
                    
                    
                    if let title = article["source"]!!["enriched"]!!["url"]!!["title"] as? String
                    {
                        print("---Title---")
                        print(title)
                        print("--- ---")
                        newsArticle.title = title
                    }
                    
                    if let url = article["source"]!!["enriched"]!!["url"]!!["url"] as? String
                    {
                        print("---Url---")
                        print(url)
                        print("--- ---")
                        newsArticle.url = url
                    }
                    
                    newsArticleDictionary.append(newsArticle)
                    
                    
                }
                */
                return NewsInformation(JSON: newsArticleDictionary)
            }
            else
            {
                return nil
            }
            
        }, completion: completion)
    }
    
}
