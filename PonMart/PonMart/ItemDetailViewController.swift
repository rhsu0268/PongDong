//
//  DetailViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/10/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    //var item : Any? = nil
    
    var item : PublicItem? = nil
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCategory: UIImageView!
    @IBOutlet var itemCondition: UIImageView!
    @IBOutlet var itemDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(item?.name)
        if let itemName = item?.name
        {
            print(itemName)
            self.itemName.text = itemName
        }
        
        if let imageUrl = item?.itemImageUrl
        {
            let url = NSURL(string: imageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                // download hit an error so we will return
                if error != nil
                {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async( execute: {
                    self.itemImage.image = UIImage(data: data!)
                })
                
                
            }).resume()
        }
        
        if let itemCategory = item?.type 
        {
            if itemCategory == "Furniture"
            {
                self.itemCategory.image = UIImage(named: "furniture-label.png")
            }
            else
            {
                self.itemCategory.image = UIImage(named: "textbook-label.png")
            }

        }
        
        if let itemCondition = item?.condition
        {
            if itemCondition == "New"
            {
                self.itemCondition.image = UIImage(named: "new-label.png")
            }
            else
            {
                self.itemCondition.image = UIImage(named: "used-label.png")
            }
            
        }
        
        if let itemDescription = item?.itemDescription
        {
            self.itemDescription.text = itemDescription
        }

        
        /*
        if let itemName = (item as AnyObject).value(forKey: "itemName") as? String
        {
            self.itemName.text = itemName
        }
        
        if let itemImage = (item as AnyObject).value(forKey: "itemImage") as? NSData
        {
            print("Set image")
            self.itemImage.image = UIImage(data: itemImage as Data)
        }
        
        if let itemCategory = (item as AnyObject).value(forKey: "itemCategory") as? String
        {
            print(itemCategory)
            if itemCategory == "Furniture"
            {
                self.itemCategory.image = UIImage(named: "furniture-label.png")
            }
            else
            {
                self.itemCategory.image = UIImage(named: "textbook-label.png")
            }

        }
        
        if let itemCondition = (item as AnyObject).value(forKey: "itemCondition") as? String
        {
            if itemCondition == "New"
            {
                self.itemCondition.image = UIImage(named: "new-label.png")
            }
            else
            {
                self.itemCondition.image = UIImage(named: "used-label.png")
            }

        }
        
        if let itemDescription = (item as AnyObject).value(forKey: "itemDescription") as? String
        {
            self.itemDescription.text = itemDescription
        }
    
        // Do any additional setup after loading the view.
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
