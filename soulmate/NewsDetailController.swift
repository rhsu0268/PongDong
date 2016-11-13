//
//  NewsDetailController.swift
//  soulmate
//
//  Created by Richard Hsu on 11/12/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {

    @IBOutlet weak var newsArticleDescriptionLabel: UILabel!
    
    
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
