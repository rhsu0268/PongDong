//
//  EditProfileViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/19/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {
    
    @IBOutlet var userProfileImage: UIImageView!
    
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var phoneNumberTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        
        // pull data out of NSUserDefaults
        //let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        let loggedInUsername = UserDefaults.standard.string(forKey: "username")
        print(loggedInUsername!)
        
        
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
    

    
}
