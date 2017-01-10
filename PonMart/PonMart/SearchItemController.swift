//
//  SearchItemController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit

class SearchItemController: UIViewController {
    
    
    @IBOutlet var textbookOption: UIButton!
    
    @IBOutlet var furnitureOption: UIButton!
    
    @IBAction func textbookOptionClicked(_ sender: UIButton) {
        
        print("TextBook selected!")
        textbookOption.setImage(UIImage(named: "textbook-button-selected.png"), for: .normal)
        furnitureOption.setImage(UIImage(named: "furniture-button-unselected.png"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        print("searchButton clicked!")
        
        // seed data
        var sampleItemData = SampleItemData()
        print(sampleItemData.items)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // create a variable to send
        var sampleItemData = SampleItemData()
        
        let navigationController = segue.destination as! UINavigationController
        let searchResultTableViewController = navigationController.topViewController as! SearchResultTableViewController
        
        searchResultTableViewController.items = sampleItemData.items
        
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
