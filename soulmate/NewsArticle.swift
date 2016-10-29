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
    var title: String
    var url: String
 
 
    init (title: String, url: String)
    {
        self.title = title
        self.url = url
    }
 
}
 
