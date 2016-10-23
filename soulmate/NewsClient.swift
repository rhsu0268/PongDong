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
    var request: NSURLRequest
    {
        
        let url = NSURL(string: "https://access.alchemyapi.com/calls/data/GetNews?apikey=0c946bde49878224025230853ec995cc1693dc3e&return=enriched.url.title,enriched.url.url&start=1473897600&end=1474585200&q.enriched.url.cleanedTitle=charlotte&q.enriched.url.enrichedTitle.docSentiment.type=negative&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=society&count=25&outputMode=json")
        return NSURLRequest(URL: url!)
        
        
     
    }
}
