//
//  RegisterViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/13/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class RegisterViewController: UIViewController {

    //@IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userEmailTextField: UITextField!
    
    @IBOutlet var userPasswordTextfield: UITextField!
    
  
    @IBOutlet var userPasswordConfirmationTextfield: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    @IBAction func RegisterButtonClicked(_ sender: UIButton) {
        
        // read the fields
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextfield.text
        let userPasswordConfirm = userPasswordConfirmationTextfield.text
        
        
        // check for empty fields
        
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)!)
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
        /*
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(userPassword, forKey: "userPassword")
        
        do
        {
            try context.save()
            print("SAVED!")
        }
        catch
        {
            
        }
        

        
        // display alert message with confirmation
        var confirmationAlert = UIAlertController(title: "Alert", message: "Your registration was successful! Welcome to PongDong", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        {
            action in
            self.dismiss(animated: true, completion: nil)
        }
        confirmationAlert.addAction(okAction)
        self.present(confirmationAlert, animated: true, completion: nil)
        */
        FIRAuth.auth()?.createUser(withEmail: userEmail!, password: userPassword!, completion: {
            
            (user: FIRUser?, error) in
            
            if error != nil
            
            {
                print(error)
                return
                
            }
            
            guard let uid = user?.uid else
            {
                return
            }
            
            // successfully authenticared user
            let ref = FIRDatabase.database().reference(fromURL: "https://pongdong-a73db.firebaseio.com/")
            
            let usersReference = ref.child("users").child(uid)
            
            let values = ["email": userEmail]
            usersReference.updateChildValues(values, withCompletionBlock: {
                
                (err, ref) in
                if err != nil
                {
                    print(err)
                    return
                }
                print("Saved user sccessfully into firebase db!")
                
                self.dismiss(animated: true, completion: nil)
                
                
            })

            
            
        })
        
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
