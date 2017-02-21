//
//  SendMessageViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/20/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class SendMessageViewController: UIViewController {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var messageTextView: UITextView!
    
    var purchaseItem : PublicItem? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(purchaseItem?.name)
        
        if let userId = purchaseItem?.userId
        {
            print(userId)
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func SendMessageButtonClicked(_ sender: UIButton) {
        
        guard let textFieldValue = messageTextView.text, !textFieldValue.isEmpty else {
            return
        }
        
        print("Sending message")
        
        sendMessage(textFieldText: textFieldValue)
        
        
        // get the text of the message
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
    
    
    func sendMessage(textFieldText : String)
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let messageRef = FIRDatabase.database().reference().child("messages")
      
        let values = ["messages": textFieldText]
        messageRef.child(uid!).updateChildValues(values)
        
    }

}
