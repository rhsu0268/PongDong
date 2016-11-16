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
    
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var rate: Float!
    var pitch: Float!
    var volume: Float!
    
    @IBAction func speakButton(sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: newsArticleDescriptionLabel.text!)
        
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitch
        speechUtterance.volume = volume
        
        speechSynthesizer.speakUtterance(speechUtterance)
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

}
