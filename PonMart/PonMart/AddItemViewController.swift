//
//  AddPongViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class AddItemViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

  
    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var itemPriceTextField: UITextField!
    
    @IBOutlet var userProfileImage: UIImageView!
    
    
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var uploadItemImageButton: UIButton!
    
    
    var itemNameText : String = ""
    var itemDescriptionText : String = ""
    var itemPriceDouble : Double = 0.0
    
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
        if let itemPrice = Double(itemPriceTextField.text!)
        {
            itemPriceDouble = itemPrice
        }
        
        
        //var item : Item = Item(name: itemNameText, description: itemDescriptionText, type: "Furniture", condition: "Used", price: 12.00, itemImage: UIImage(named:"sofa.jpeg")!)
        //print(item)
        
        /*
        let context = appDelegate.persistentContainer.viewContext
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context)
        
        newItem.setValue("rhsu0268", forKey: "username")
        newItem.setValue(itemNameText, forKey: "itemName")
        newItem.setValue(itemCategory, forKey: "itemCategory")
        newItem.setValue(itemCondition, forKey: "itemCondition")
        newItem.setValue(itemPriceDouble, forKey: "itemPrice")
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
         */
        addItem(itemName: "Sofa")

        
    }
    
    
    @IBAction func furnitureOptionClicked(_ sender: UIButton) {
        
        furnitureOption.setImage(UIImage(named: "furniture-label-selected"), for: .normal)
        textbookOption.setImage(UIImage(named: "textbook-label-unselected"), for: .normal)
        itemCategory = "Furniture"
    }
    
    
    @IBAction func textbookOptionClicked(_ sender: UIButton) {
        
        textbookOption.setImage(UIImage(named: "textbook-label-selected"), for: .normal)
        furnitureOption.setImage(UIImage(named: "furniture-label-unselected"), for: .normal)
        itemCategory = "Textbook"
    }
    
    
    @IBAction func newOptionClicked(_ sender: UIButton) {
        
        newOption.setImage(UIImage(named: "new-label-selected"), for: .normal)
        usedOption.setImage(UIImage(named: "used-label-unselected"), for: .normal)
        itemCondition = "New"
    }
    
    @IBAction func usedOptionClicked(_ sender: UIButton) {
        
        usedOption.setImage(UIImage(named: "used-label-selected"), for: .normal)
        newOption.setImage(UIImage(named: "new-label-unselected"), for: .normal)
        itemCondition = "Used"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userProfileImage.image = nil
        // Do any additional setup after loading the view.
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        
        // storing core data
        
        let itemImageTap = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.itemImageTapFunction))
        
        itemImage.addGestureRecognizer(itemImageTap)
        
        getUserProfileImage()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ProfileOptionButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func SearchOptionButtonClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addPongViewToSearchView", sender: self)
    }
    
    
    
    func addItem(itemName : String)
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let userItemsReference = FIRDatabase.database().reference().child("userItems").child(uid!)
        
        userItemsReference.updateChildValues(["itemName": itemName])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func itemImageTapFunction(sender: UITapGestureRecognizer)
    {
        print("You tapped item")
        var imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
        
            imagePickerController.allowsEditing = true
        //imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            selectedImageFromPicker = editedImage
            //print(editedImage.size)
        }
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            print(originalImage.size)
            self.itemImage.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func UploadItemImageButtonClicked(_ sender: UIButton) {
        print("Upload")
        
        uploadItemImageButton.isEnabled = false
        
        // create a random string
        let imageName = NSUUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("item_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.itemImage.image!)
        {
            storageRef.put(uploadData, metadata: nil, completion: {
                (metadata, error) in
                
                if error != nil
                {
                    print(error)
                    return
                }
                
                print(metadata)
                
                self.displayAlertMessage(userMessage: "You have successfully uploaded a profile Image")
                
                self.uploadItemImageButton.isEnabled = true
                
                if let itemImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    self.saveImageToItem(url: itemImageUrl)
                }
            })
            
        }
        
    }
    
    func saveImageToItem(url: String)
    {
        // save it
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let itemReference = FIRDatabase.database().reference().child("userItems").child(uid!)
        
        itemReference.updateChildValues(["profileImageURL": url])
    }
    
    func displayAlertMessage(userMessage: String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okayAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func getUserProfileImage()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
            
            (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                print(dictionary["profileImageURL"] as? String)
                // check whether key exists
                if let keyExists = dictionary["profileImageURL"]
                {
                    let url = NSURL(string: (dictionary["profileImageURL"] as? String)!)
                    
                    URLSession.shared.dataTask(with: url as! URL, completionHandler: {
                        
                        (data, response, error) in
                        
                        // download hit an error so lets return out
                        if error != nil
                        {
                            print(error)
                            return
                        }
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.userProfileImage.image = UIImage(data: data!)
                            
                        })
                        
                    }).resume()
                }
                else
                {
                    // set a placeholder
                    self.userProfileImage.image = UIImage(named: "user-profile-placeholder")
                }
            }
            
            
        }, withCancel: nil)
        
    }


        

}
