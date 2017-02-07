//
//  UserProfileViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet var userProfileImage: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        //self.userProfileImage.layer.cornerRadius = 10.0
        
        //if let pr
        //self.userProfileImage = UIImage(
        
        getUserProfileImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    @IBAction func ExitButtonClicked(_ sender: UIButton) {
        
        //UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        //UserDefaults.standard.synchronize()
        do
        {
            try FIRAuth.auth()?.signOut()
        }
        catch let logoutError
        {
            print(logoutError)
        }
        
        // go to login
        performSegue(withIdentifier: "profileViewToLoginView", sender: self)

    }
    @IBAction func SearchOptionButtonClicked(_ sender: UIButton) {
        
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "profileViewToSearchView", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getUserProfileImage()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
            
            (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                print(dictionary["profileImageURL"] as? String)
                
                let url = NSURL(string: (dictionary["profileImageURL"] as? String)!)
                URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                    
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
            
            
        }, withCancel: nil)

    }

}
