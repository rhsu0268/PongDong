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

        
        let image = userProfileImage.image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        tempImageRef.put(UIImageJPEGRepresentation(image!, 0.8)!, metadata: metaData)
        {
            (data, error) in
            
            if error == nil
            {
                print("upload successful!")
            }
            else
            {
                print(error?.localizedDescription)
            }
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
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary 
        
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
        uploadImageToServer(url: localPath!)
    }
    
    
    
    func uploadImageToServer(url : NSURL)
    {
        //let url = URL("http://localhost:3000/uploadTest")
        
        /*
        let parameters = [
            "parameter1": "bodrum",
            "parameter2": "yalikavak"]
        
        let headers: HTTPHeaders = [
            "Content-Type" : "text/html; charset=utf-8"
        ]

        
        //let URL = try! URLRequest(url: "http://localhost:3000/post", method: .post)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(UIImagePNGRepresentation(self.userProfileImage.image!)!, withName: "signImg", fileName: "picture.png", mimeType: "image/png")
        }, with: URL, encodingCompletion: {
            encodingResult in
            print("--- Encoding result ---")
            print(encodingResult)
            print("--- ---")
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseString { response in
                    debugPrint("SUCCESS RESPONSE: (response)")
                }
            case .failure(let encodingError):
                // hide progressbas here
                print("ERROR RESPONSE: (encodingError)")
            }
        })
        */
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        imageURL              = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName         = imageURL?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        photoURL              = NSURL(fileURLWithPath: documentDirectory)
        localPath         = photoURL?.appendingPathComponent(imageName!) as NSURL?
        let image             = info[UIImagePickerControllerOriginalImage]as! UIImage
        let data              = UIImagePNGRepresentation(image)
        
        /*
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
        
        print(localPath)
        print("--- ---")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.userProfileImage.image = image
        }
        else
        {
            print("Problem with picking image!")
        }
        


        self.dismiss(animated: true, completion: nil)
    }
    
}


