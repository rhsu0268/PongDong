//
//  LoginViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var userPasswordTextField: UITextField!
    
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        
        
        let username = usernameTextField.text
        let userPassword = userPasswordTextField.text
        
        
        // send username and userPassword and do verification 
        
        // 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
