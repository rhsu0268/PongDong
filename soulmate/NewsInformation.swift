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
    let newsArticles: [NewsArticle]
    

}

extension NewsInformation
{
    init? (JSON: [NewsArticle])
    {
        /*
        guard let data = JSON as? [NewsArticle]
        else
        {
            return nil
        }
        */
        
        self.newsArticles = JSON
    }
}


