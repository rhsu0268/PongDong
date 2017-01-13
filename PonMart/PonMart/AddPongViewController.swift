//
//  AddPongViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData

class AddPongViewController: UIViewController {

    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextView!
    
    @IBOutlet var userProfileImage: UIImageView!
    
    var itemNameText : String = ""
    var itemDescriptionText : String = ""
    
    var itemCategory : String = ""
    var itemCondition : String = ""
    
    @IBOutlet var furnitureOption: UIButton!
    @IBOutlet var textbookOption: UIButton!
    
    
    @IBOutlet var newOption: UIButton!
    @IBOutlet var usedOption: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        
        
        //var item : Item = Item(name: itemNameText, description: itemDescriptionText, type: "Furniture", condition: "Used", price: 12.00, itemImage: UIImage(named:"sofa.jpeg")!)
        //print(item)
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context)
        
        newItem.setValue("rhsu0268", forKey: "username")
        newItem.setValue(itemNameText, forKey: "itemName")
        newItem.setValue("Furniture", forKey: "itemCategory")
        newItem.setValue("Used", forKey: "itemCondition")
        newItem.setValue(150, forKey: "itemPrice")
        newItem.setValue(itemDescriptionText, forKey: "itemDescription")
        
        
        let imageData : NSData = UIImagePNGRepresentation(UIImage(named: "sofa.jpeg")!)! as NSData
        newItem.setValue(imageData, forKey: "itemImage")
        
        
        do
        {
            try context.save()
            print("SAVED!")
        }
        catch
        {
            
        }

        
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
        
        // storing core data
        
        
        
        
        
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
