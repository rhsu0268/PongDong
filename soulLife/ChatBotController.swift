//
//  ChatbotController.swift
//  soulLife
//
//  Created by Richard Hsu on 12/29/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import Speech

class ChatbotController: UIViewController, SFSpeechRecognizerDelegate {
    
    
    @IBOutlet weak var speechQuestionLabel: UILabel!
    
    @IBOutlet weak var userText: UILabel!
    
    
    @IBOutlet weak var microphoneButton: UIButton!
    
    
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
    
    
    @IBAction func microphoneTapped(_ sender: UIButton) {
    }
    
    

}
