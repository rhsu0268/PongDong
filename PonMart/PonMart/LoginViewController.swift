//
//  LoginViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var userPasswordTextField: UITextField!
    
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        
        
        //let username = usernameTextField.text
        //let userPassword = userPasswordTextField.text
        
        
        // send username and userPassword and do verification 
        
        guard let email = emailTextField.text, let password = userPasswordTextField.text
        else
        {
            print("Form is not valid!")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            
            if error != nil
            {
                print(error)
                return
            }
            
            print("Success")
            // login the user
            self.performSegue(withIdentifier: "LoginViewToSearchView", sender: nil)
        })
        
        /*
        // pull out data
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let users = try context.fetch(request)
            if users.count > 0
            {
                for user in users as! [NSManagedObject]
                {
                    if let currentUsername = user.value(forKey: "username") as? String
                    {
                        print(currentUsername)
                        
                        if (username == currentUsername)
                        {
                            if let currentPassword = user.value(forKey: "userPassword") as? String
                            {
                                if userPassword == currentPassword
                                {
                                    print("You are logged in!")
                                    //displayAlertMessage(userMessage: "You are logged in. Welcome to PongDong!")
                                    //self.presentedViewController("SearchItemController", nil)
                                    
                                    // keep track of logged in status
                                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                    UserDefaults.standard.synchronize()
                                    
                                    // keep track of logged in user
                                    UserDefaults.standard.set(username, forKey: "username")
                                    UserDefaults.standard.synchronize()
                                    
                                    var confirmationAlert = UIAlertController(title: "Alert", message: "You are logged in. Welcome to PongDong!", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                                    {
                                        action in
                                        self.performSegue(withIdentifier: "LoginViewToSearchView", sender: nil)
                                    }
                                    confirmationAlert.addAction(okAction)
                                    self.present(confirmationAlert, animated: true, completion: nil)
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
                displayAlertMessage(userMessage: "Please check your credentails!")
            }
        }
        catch
        {
            // process error
        }
        
        */
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayAlertMessage(userMessage: String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okayAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if isUserLoggedIn
        {
            self.performSegue(withIdentifier: "LoginViewToSearchView", sender: self)
        }
         */
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn()
    {
        if FIRAuth.auth()?.currentUser?.uid == nil
        {
            //dismiss(animated: true, completion: nil)
            print("Not logged in ")
        }
        else
        {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
                
                (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]
                {
                    print(dictionary["email"] as? String)
                }
                
                
            }, withCancel: nil)
            
            self.performSegue(withIdentifier: "LoginViewToSearchView", sender: self)
            
            
            
        }
    }


}
