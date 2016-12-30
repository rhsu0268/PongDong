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
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        microphoneButton.isEnabled = false
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization
        {
            (authStatus) in
            
            
            var isMicrophoneButtonEnabled = false
            
            switch authStatus
            {
                case .authorized:
                    isMicrophoneButtonEnabled = true
                
                case .denied:
                    isMicrophoneButtonEnabled = false
                    print("User denied access to speech recognition!")
                
                case .restricted:
                    isMicrophoneButtonEnabled = false
                    print("Speech recognition restricted on this device!")
                case .notDetermined:
                    isMicrophoneButtonEnabled = false
                    print("Speech recognition not yet authorized!")
            }
            
            OperationQueue.main.addOperation()
            {
                self.microphoneButton.isEnabled = isMicrophoneButtonEnabled
            }
        }
      
        
        
        
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
