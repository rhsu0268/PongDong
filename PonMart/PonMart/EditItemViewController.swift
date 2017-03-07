//
//  EditItemViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 3/6/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class EditItemViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    @IBOutlet var editButton: UIButton!
    
    var newImageUploaded : Bool = false
    
    
    
    @IBAction func FurnitureButtonClicked(_ sender: UIButton) {
        furnitureButton.setImage(UIImage(named: "furniture-label-selected"), for: .normal)
        textbookButton.setImage(UIImage(named: "textbook-label-unselected"), for: .normal)
        itemCategory = "Furniture"
    }
    
    
    
    @IBAction func TextBookButtonClicked(_ sender: UIButton) {
        textbookButton.setImage(UIImage(named: "furniture-label-selected"), for: .normal)
        furnitureButton.setImage(UIImage(named: "textbook-label-unselected"), for: .normal)
        itemCategory = "Textbook"
    }
    
    @IBAction func NewButtonClicked(_ sender: UIButton) {
        
        newButton.setImage(UIImage(named: "new-label-selected"), for: .normal)
        usedButton.setImage(UIImage(named: "used-label-unselected"), for: .normal)
        itemCondition = "New"
    }
    
    @IBAction func UsedButtonClicked(_ sender: UIButton) {
        
        usedButton.setImage(UIImage(named: "used-label-selected"), for: .normal)
        newButton.setImage(UIImage(named: "new-label-unselected"), for: .normal)
        
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
            itemCategory = "Furniture"
        }
        else
        {
            textbookButton.setImage(UIImage(named: "textbook-label-selected"), for: .normal)
            itemCategory = "Textbook"
        }
        
        
        if userItem?.itemCondition == "Used"
        {
            usedButton.setImage(UIImage(named: "used-label-selected"), for: .normal)
            itemCondition = "Used"
        }
        else
        {
            newButton.setImage(UIImage(named: "new-label-selected"), for: .normal)
            itemCondition = "New"
        }
        
        itemDescription.text = userItem?.itemDescription
        
        
        // load the image
        itemImage.loadImageUsingCacheWithUrlString(urlString: (userItem?.itemImageUrl)!)
        
        
        let itemImageTap = UITapGestureRecognizer(target: self, action: #selector(EditItemViewController.itemImageTapFunction))
        
        itemImage.addGestureRecognizer(itemImageTap)

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            self.newImageUploaded = true
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func EditItemButtonClicked(_ sender: UIButton) {
        
        // get all the fields
        
        var editedItemName = itemName.text
        var editedItemPrice = itemPrice.text
        var editedCategory = itemCategory
        var editedCondition = itemCondition
        var editedDescription = itemDescription.text
        
        
        print(editedItemName)
        
        editItem(editedCategory: editedCategory, editedCondition: editedCondition, editedDescription: editedDescription!, editedItemName: editedItemName!, editedItemPrice: editedItemPrice!)
        
        
    }
    
    func editItem(editedCategory : String, editedCondition : String, editedDescription : String, editedItemName : String, editedItemPrice : String)
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let itemId = userItem?.itemId
        let itemRef = FIRDatabase.database().reference().child("userItems").child(uid!).child(itemId!)
        
        itemRef.updateChildValues(["createdDate": userItem?.createdDate])
        itemRef.updateChildValues(["itemCategory": editedCategory])
        itemRef.updateChildValues(["itemCondition": editedCondition])
        itemRef.updateChildValues(["itemDescription": editedDescription])
        //itemRef.updateChildValues(["itemImageUrl": ])
        itemRef.updateChildValues(["itemName": editedItemName])
        itemRef.updateChildValues(["itemPrice": editedItemPrice])
        itemRef.updateChildValues(["publicOrPrivate": userItem?.publicOrPrivate])
        itemRef.updateChildValues(["itemPrice": editedItemPrice])
        
        let date = Foundation.Date()
        let formatedDate = date.dateToString()
        
        itemRef.updateChildValues(["updatedDate": formatedDate])
        
        if (newImageUploaded)
        {
            uploadImage(key: itemId!)
        }
        
    }
    
    
    func uploadImage(key : String)
    {
        print("Upload")
        
        //uploadItemButton.isEnabled = false
        
        // create a random string
        let imageName = NSUUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("userItem_images").child("\(imageName).jpg")
        
        //if let uploadData = UIImageJPEGRepresentation(self.itemImage.image!, 0.1)
        
        //if let uploadData = UIImagePNGRepresentation(self.itemImage.image!)
        if let itemImage = self.itemImage.image, let uploadData = UIImageJPEGRepresentation(itemImage, 0.1)
        {
            storageRef.put(uploadData, metadata: nil, completion: {
                (metadata, error) in
                
                if error != nil
                {
                    print(error)
                    return
                }
                
                print(metadata)
                
                //self.displayAlertMessage(userMessage: "You have successfully uploaded a profile Image")
                
                
                
                if let itemImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    self.saveImageToItem(url: itemImageUrl, key: key)
                }
                
                self.editButton.isEnabled = true
                self.editItemActivityIndicator.stopAnimating()
                
                
                
            })
            
        }
        
        
    }
    
    func saveImageToItem(url: String, key: String)
    {
        // save it
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let itemReference = FIRDatabase.database().reference().child("userItems").child(uid!).child(key)
        
        
        itemReference.updateChildValues(["itemImageURL": url])
        
        editButton.isEnabled = true
        //self.performSegue(withIdentifier: "addItemViewToUserItemView", sender: self)
        
    }

    

}
