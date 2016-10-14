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

extension NewsInformation: JSONDecodable
{
    /*
    init?(JSON: [String : AnyObject])
    {
        //guard let temperature = JSON["temperature"] as? Double,
        //humidity = JSON["humidity"] as? Double,
        // precipitationProbablity = JSON["precipProbability"] as? Double
        //summary = JSON["summary"] as? String,
        // iconString = JSON["icon"] as? String else
        //{
            //return nil
        //}
        
        //let icon = WeatherIcon(rawValue: iconString).image
        //self.temperature = temperature
        //self.humidity = humidity
        //self.precipitationProbability = precipitationProbability
        //self.summary = summary
        //self.icon = icon
        
        
    }
     */
}
