//
//  NewsArticle.swift
//  soulmate
//
//  Created by Richard Hsu on 10/28/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation


class NewsArticle: NSObject
{
    var author: String
    var newsDescription: String
    var publishedAt: String
    var title: String
    var url: String
    var urlToImage: String
    
 
 
    init (author: String, descripton: String, publishedAt: String, title: String, url: String, urlToImage: String)
    {
        self.author = author
        self.newsDescription = description
        self.publishedAt = publishedAt
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
    }
 
}
 
