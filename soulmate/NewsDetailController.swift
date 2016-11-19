//
//  NewsDetailController.swift
//  soulmate
//
//  Created by Richard Hsu on 11/12/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import AVFoundation

class NewsDetailController: UIViewController {

    @IBOutlet weak var newsArticleDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var speakButtonLabel: UIButton!
    
    
    @IBOutlet weak var pauseButtonLabel: UIButton!
    
    @IBOutlet weak var stopButtonLabel: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var rate: Float!
    var pitch: Float!
    var volume: Float!
    
    @IBAction func speakButton(sender: UIButton) {
        
        if !speechSynthesizer.speaking
        {
            let speechUtterance = AVSpeechUtterance(string: newsArticleDescriptionLabel.text!)
        
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitch
            speechUtterance.volume = volume
        
            speechSynthesizer.speakUtterance(speechUtterance)
        }
        else
        {
            speechSynthesizer.continueSpeaking()
        }
        animateActionButtonAppearaance(true)
    }
    
    var article: NewsArticle?
    {
        didSet
        {
            // update the view
            self.configureView()
        }
    }
    
    
    
    func configureView()
    {
        if let article = self.article
        {
            print("---Article---")
            print(article.newsDescription)
            print("---  ---")
            
            
            if let label = self.newsArticleDescriptionLabel
            {
                label.text = article.newsDescription
            }
 
            
            //newsArticleDescriptionLabel.text = article.newsDescription
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
        //newsArticleDescriptionLabel.text = article?.description
        pauseButtonLabel.alpha = 0.0
        stopButtonLabel.alpha = 0.0
        
        print(AVSpeechSynthesisVoice.speechVoices())
        
        if !loadSettings()
        {
            registerDefaultSettings()
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
    
    func registerDefaultSettings()
    {
        rate = AVSpeechUtteranceDefaultSpeechRate
        pitch = 1.0
        volume = 1.0
        
        let defaultSpeechSettings: Dictionary<String, AnyObject> = ["rate": rate, "pitch": pitch, "volume": volume]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultSpeechSettings)
        
    }
    
    func loadSettings() -> Bool
    {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        
        
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float
        {
            rate = theRate
            pitch = userDefaults.valueForKey("pitch") as! Float
            volume = userDefaults.valueForKey("volume") as! Float
            
            return true
        }
        return false
    }
    
    
    
    @IBAction func pauseButton(sender: UIButton) {
        
        speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        
        animateActionButtonAppearaance(false)
    }
    
    
    @IBAction func stopButton(sender: UIButton) {
        
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        animateActionButtonAppearaance(false)
    }
    
    func animateActionButtonAppearaance(shouldHideSpeakButton: Bool)
    {
        var speakButtonAlphaValue: CGFloat = 1.0
        var pauseStopButtonAlphaValue: CGFloat = 0.0
        
        if shouldHideSpeakButton
        {
            speakButtonAlphaValue = 0.0
            pauseStopButtonAlphaValue = 1.0
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.speakButtonLabel.alpha = speakButtonAlphaValue
            
            self.pauseButtonLabel.alpha = pauseStopButtonAlphaValue
            
            self.stopButtonLabel.alpha = pauseStopButtonAlphaValue
            
        })
    }
    

}
