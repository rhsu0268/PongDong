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
    
    @IBOutlet var userProfileImage: UIImageView!
    
    var itemNameText : String = ""
    var itemDescriptionText : String = ""
    
    
    @IBOutlet var furnitureOption: UIButton!
    @IBOutlet var textbookOption: UIButton!
    
    
    @IBOutlet var newOption: UIButton!
    @IBOutlet var usedOption: UIButton!
    
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
    
    
    @IBAction func furnitureOptionClicked(_ sender: UIButton) {
        
        furnitureOption.setImage(UIImage(named: "furniture-label-selected"), for: .normal)
        textbookOption.setImage(UIImage(named: "textbook-label-unselected"), for: .normal)
    }
    
    
    @IBAction func textbookOptionClicked(_ sender: UIButton) {
        
        textbookOption.setImage(UIImage(named: "textbook-label-selected"), for: .normal)
        furnitureOption.setImage(UIImage(named: "furniture-label-unselected"), for: .normal)
    }
    
    
    @IBAction func newOptionClicked(_ sender: UIButton) {
        
        newOption.setImage(UIImage(named: "new-label-selected"), for: .normal)
        usedOption.setImage(UIImage(named: "used-label-unselected"), for: .normal)
    }
    
    @IBAction func usedOptionClicked(_ sender: UIButton) {
        
        usedOption.setImage(UIImage(named: "used-label-selected"), for: .normal)
        newOption.setImage(UIImage(named: "new-label-unselected"), for: .normal)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        
        
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
