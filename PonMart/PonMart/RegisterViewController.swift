//
//  RegisterViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/13/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var userPasswordTextfield: UITextField!
    
  
    @IBOutlet var userPasswordConfirmationTextfield: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    @IBAction func RegisterButtonClicked(_ sender: UIButton) {
        
        // read the fields
        let username = userNameTextField.text
        let userPassword = userPasswordTextfield.text
        let userPasswordConfirm = userPasswordConfirmationTextfield.text
        
        
        // check for empty fields
        if ((username?.isEmpty)! || (userPassword?.isEmpty)!)
        {
            // display alert message
            displayAlertMessage(userMessage: "All fields are required!")
            return
        }
        // check if the passwords match 
        if (userPassword != userPasswordConfirm)
        {
            // display alert message
            displayAlertMessage(userMessage: "Your passwords do not match!")
            
            return
        }
        
        // store data
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(userPassword, forKey: "userPassword")

        
        // display alert message with confirmation
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
