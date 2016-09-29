//
//  NewsInformation.swift
//  soulmate
//
//  Created by Richard Hsu on 9/23/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

class NewsInformation: NSObject
{
    var title: String
    var url: String
    
    
    init (title: String, url: String)
    {
        self.title = title
        self.url = url
    }
 
}
