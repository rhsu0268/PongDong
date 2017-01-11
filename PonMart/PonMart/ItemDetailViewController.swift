//
//  DetailViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/10/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var item : Item? = nil
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var conditionImage: UIImageView!
    @IBOutlet var itemDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(item)
        print(item?.name)
        
        
        if let itemImage = item?.itemImage
        {
            self.itemImage.image = itemImage
        }
        if let itemName = item?.name
        {
            self.itemName.text = itemName
        }
        if let itemDescription = item?.description
        {
            self.itemDescription.text = itemDescription
        }
        // Do any additional setup after loading the view.
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
