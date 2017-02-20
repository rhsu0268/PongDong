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

        // Do any additional setup after loading the view.
    }

    @IBAction func SendMessageButtonClicked(_ sender: UIButton) {
        
        print("Sending message")
        
        
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

}
