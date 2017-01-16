//
//  LoginViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var userPasswordTextField: UITextField!
    
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        
        
        let username = usernameTextField.text
        let userPassword = userPasswordTextField.text
        
        
        // send username and userPassword and do verification 
        
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

}
