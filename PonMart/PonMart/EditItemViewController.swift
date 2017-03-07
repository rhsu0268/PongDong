//
//  EditItemViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 3/6/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {

    var userItem : UserItem? = nil
    
    @IBOutlet var itemImage: UIImageView!
    
    
    
    @IBOutlet var editItemActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemPrice: UITextField!
    
    

    @IBOutlet var furnitureButton: UIButton!
    @IBOutlet var textbookButton: UIButton!
    
    @IBOutlet var newButton: UIButton!
    @IBOutlet var usedButton: UIButton!
    
    
    var itemCategory : String = ""
    var itemCondition : String = ""
    
    @IBAction func FurnitureButtonClicked(_ sender: UIButton) {
        itemCategory = "Furniture"
    }
    
    
    
    @IBAction func TextBookButtonClicked(_ sender: UIButton) {
        itemCategory = "Textbook"
    }
    
    @IBAction func NewButtonClicked(_ sender: UIButton) {
        
        itemCondition = "New"
    }
    
    @IBAction func UsedButtonClicked(_ sender: UIButton) {
        itemCondition = "Used"
    }
    
    @IBOutlet var itemDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Edit Item")
        print(userItem?.itemName)
        
        itemName.text = userItem?.itemName
        print(userItem?.itemPrice)
        
        if let price = userItem?.itemPrice
        {
            print(price)
            itemPrice.text = "\(price)"
        }
        
        
        if userItem?.itemCategory == "Furniture"
        {
            furnitureButton.setImage(UIImage(named: "furniture-label-selected"), for: .normal)
        }
        else
        {
            textbookButton.setImage(UIImage(named: "textbook-label-selected"), for: .normal)
        }
        
        
        if userItem?.itemCondition == "Used"
        {
            usedButton.setImage(UIImage(named: "used-label-selected"), for: .normal)
        }
        else
        {
            newButton.setImage(UIImage(named: "new-label-selected"), for: .normal)
        }
        
        itemDescription.text = userItem?.itemDescription
        
        
        // load the image
        itemImage.loadImageUsingCacheWithUrlString(urlString: (userItem?.itemImageUrl)!)
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
