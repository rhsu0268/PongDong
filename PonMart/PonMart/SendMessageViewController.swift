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
        let fromId = FIRAuth.auth()?.currentUser?.uid
        let toId = purchaseItem?.userId
        let messageFromRef = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        let date = Foundation.Date()
        let formattedDate = date.chatDateToString()
        
        let values = ["text": textFieldText, "toId": toId, "fromId": fromId, "timestamp": formattedDate]
        messageFromRef.updateChildValues(values)
        self.dismiss(animated: true, completion: nil)
        
    }

}
