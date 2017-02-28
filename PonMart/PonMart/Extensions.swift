//
//  Extensions.swift
//  PonMart
//
//  Created by Richard Hsu on 2/19/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView
{
    func loadImageUsingCacheWithUrlString(urlString: String)
    {
        
        self.image = nil
        
        // check cache for image first
        
       
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage
        {
            self.image = cachedImage
            return
        }
        
        // otherwise fire off a new download
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url as! URL, completionHandler: {
            
            (data, response, error) in
            
            // download hit an error so lets return out
            if error != nil
            {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!)
                {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
                
                
                //self.userProfileImage.image = UIImage(data: data!)
                self.image = UIImage(data: data!)
                
            })
            
        }).resume()
    }
}

extension Foundation.Date {
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        let date = self
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func chatDateToString() -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short 
        let date = self
        
        return dateFormatter.string(from: date)
    }
}
