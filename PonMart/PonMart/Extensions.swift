//
//  Extensions.swift
//  PonMart
//
//  Created by Richard Hsu on 2/19/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func loadImageUsingCacheWithUrlString(urlString: String)
    {
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
                
                //self.userProfileImage.image = UIImage(data: data!)
                self.image = UIImage(data: data!)
                
            })
            
        }).resume()
    }
}
