//
//  EditProfileViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/19/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
//import Alamofire
import Firebase

class EditProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoURL : NSURL? = nil
    var imageURL : NSURL? = nil
    var localPath : NSURL? = nil
    
    
    @IBOutlet var updateProfileButton: UIButton!
    @IBOutlet var imageUploadActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var cityNameLabel: UILabel!
    //@IBOutlet var cityNamePicker: UIPickerView!
    
    @IBOutlet var placeNamePicker: UIPickerView!
    
    @IBOutlet var stateNameLabel: UILabel!
    
    var cityLabelClicked = false
    var stateLabelClicked = false
    
    @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    
    let cityNamePickerData = ["New York", "Washington"]
    let stateNamePickerData = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "DC", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        
        let tempImageRef = storage.child("tmpDir/tmpImage.jpg")
        

        // Do any additional setup after loading the view.
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        
        // pull data out of NSUserDefaults
        //let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        let loggedInUsername = UserDefaults.standard.string(forKey: "username")
        print(loggedInUsername!)
        
        
        placeNamePicker.dataSource = self
        placeNamePicker.delegate = self
        
        
        let cityTap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.cityTapFunction))
        
        let stateTap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.stateTapFunction))
        
        cityNameLabel.addGestureRecognizer(cityTap)
        stateNameLabel.addGestureRecognizer(stateTap)
        
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.profileTapFunction))
        
        userProfileImage.addGestureRecognizer(profileImageTap)
    
        
        
        // 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    print(result)
                    if let userName = result.value(forKey: "username") as? String
                    {
                        print(userName)
                        
                        
                        //UserDefaults.standard.set(result, forKey: "userInfo")
                        //UserDefaults.standard.synchronize()
                    }
                }
                    
            }
            
        }
        catch
        {
            // process error
        }

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func UpdateButtonClicked(_ sender: UIButton) {
        
        // check and see if image is uploaded
        
        print("Update button clicked!")
        
        var username = usernameTextField.text
        var email = emailTextField.text
        var phoneNumber = phoneNumberTextField.text
        
       
        
        //let user = UserDefaults.standard.object(forKey: "userInfo")
        //print(user)
        
        // find the user
        
        
    }
    
    
    // MARK: -Tap recongizers
    func cityTapFunction(sender: UITapGestureRecognizer)
    {
        print("You tapped city")
        cityLabelClicked = true
        stateLabelClicked = false
        DispatchQueue.main.async {
            self.placeNamePicker.reloadAllComponents()
        }
    }
    
    func stateTapFunction(sender: UITapGestureRecognizer)
    {
        print("You tapped state")
        stateLabelClicked = true
        cityLabelClicked = false
        DispatchQueue.main.async {
            self.placeNamePicker.reloadAllComponents()
        }
    }
    
    func profileTapFunction(sender: UITapGestureRecognizer)
    {
        print("You tapped profile")
        
        // instantiate a pickerController
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        //imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
        
    // MARK: -Delegates and data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if cityLabelClicked
        {
            return cityNamePickerData.count
        }
        else
        {
            return stateNamePickerData.count
        }
        
    }
    
    // MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if cityLabelClicked
        {
            return cityNamePickerData[row]
        }
        else
        {
            return stateNamePickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if cityLabelClicked
        {
            cityNameLabel.text = cityNamePickerData[row]
        }
        else
        {
            stateNameLabel.text = stateNamePickerData[row]
        }
        
    }
    
    /*
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userProfileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        
    }
    */
    
    @IBAction func UploadButtonClicked(_ sender: UIButton) {
        
        print("Uploading image!")
        uploadImageToServer()
    }
    
    
    
    func uploadImageToServer()
    {
        updateProfileButton.isEnabled = false
        
        // create a random string
        let imageName = NSUUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.userProfileImage.image!)
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
                self.updateProfileButton.isEnabled = true
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    print(profileImageUrl)
                    self.saveImageIntoProfile(url: profileImageUrl)
                }
                
                

                
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        /*
        imageURL              = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName         = imageURL?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        photoURL              = NSURL(fileURLWithPath: documentDirectory)
        localPath         = photoURL?.appendingPathComponent(imageName!) as NSURL?
        let image             = info[UIImagePickerControllerOriginalImage]as! UIImage
        let data              = UIImagePNGRepresentation(image)
        
 
        do
        {
            try data?.write(to: localPath! as URL, options: Data.WritingOptions.atomic)
        }
        catch
        {
            // Catch exception here and act accordingly
        }
        print("--- ---")
         */
        
        var selectedImageFromPicker: UIImage?
        
       
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            selectedImageFromPicker = editedImage
            print(editedImage.size)
        }
    
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            print(originalImage.size)
            self.userProfileImage.image = originalImage
        }
 
        if let selectedImage = selectedImageFromPicker
        {
            self.userProfileImage.image = selectedImage
        }
 
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlertMessage(userMessage: String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okayAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func saveImageIntoProfile(url: String)
    {
        // save it
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let userReference = FIRDatabase.database().reference().child("users").child(uid!)
        
        userReference.updateChildValues(["state": "DC"])
        userReference.updateChildValues(["profileImageURL": url])
    }
    
}


