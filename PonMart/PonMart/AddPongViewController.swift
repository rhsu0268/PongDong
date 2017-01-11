//
//  AddPongViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class AddPongViewController: UIViewController {

    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextView!
    
    var itemNameText : String = ""
    var itemDescriptionText : String = ""
    
    @IBAction func AddPongClicked(_ sender: UIButton) {
        
        
        print("Adding item!")
        
        // create a new item 
        
        if let itemName = itemName.text
        {
            itemNameText = itemName
        }
        if let itemDescription = itemDescription.text
        {
            itemDescriptionText = itemDescription
        }
        
        
        var item : Item = Item(name: itemNameText, description: itemDescriptionText, type: "Furniture", condition: "Used", price: 12.00, itemImage: UIImage(named:"sofa.jpeg")!)
        print(item)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
