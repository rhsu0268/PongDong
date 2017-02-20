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

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailViewToSendMessageView")
        {
            var sendMessageViewController = segue.destination as! SendMessageViewController
            sendMessageViewController.purchaseItem = item
            print("Sending Item")
        }
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
