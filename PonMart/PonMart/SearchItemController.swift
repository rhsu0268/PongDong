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
    
    @IBOutlet var newOption: UIButton!
    @IBOutlet var usedOption: UIButton!
    
    @IBAction func textbookOptionClicked(_ sender: UIButton) {
        
        print("TextBook selected!")
        textbookOption.setImage(UIImage(named: "textbook-button-selected.png"), for: .normal)
        furnitureOption.setImage(UIImage(named: "furniture-button-unselected.png"), for: .normal)
    }
    
    
    @IBAction func furnitureOptionClicked(_ sender: UIButton) {
        
        furnitureOption.setImage(UIImage(named: "furniture-button-selected.png"), for: .normal)
        textbookOption.setImage(UIImage(named: "textbook-button-unselected.png"), for: .normal)
        
    }
    
    @IBAction func newOptionClicked(_ sender: UIButton) {
        
        newOption.setImage(UIImage(named: "new-button-selected.png"), for: .normal)
        usedOption.setImage(UIImage(named: "used-button-unselected.png"), for: .normal)
    }
    
    
    @IBAction func usedOptionClicked(_ sender: UIButton) {
        
        usedOption.setImage(UIImage(named: "used-button-selected.png"), for: .normal)
        newOption.setImage(UIImage(named: "new-button-unselected.png"), for: .normal)
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
        
        
        
        if (segue.identifier == "SearchItemViewToResultsTableView")
        {
            // create a variable to send
            var sampleItemData = SampleItemData()
        
        
            let navigationController = segue.destination as! UINavigationController
            let searchResultTableViewController = navigationController.topViewController as! SearchResultTableViewController
        
            searchResultTableViewController.items = sampleItemData.items
        }
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
