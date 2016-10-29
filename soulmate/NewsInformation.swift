//
//  NewsInformation.swift
//  soulmate
//
//  Created by Richard Hsu on 9/23/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation




struct NewsInformation
{
    let newsArticles: [String : AnyObject]
    

}

extension NewsInformation: JSONDecodable
{
    init? (JSON: [String : AnyObject])
    {
        guard let data = JSON as? [String : AnyObject]
        else
        {
            return nil
        }
        
        self.newsArticles = data
    }
}


