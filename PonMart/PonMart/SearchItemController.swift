//
//  SearchItemController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SearchItemController: UIViewController {
    
    var publicItems = [PublicItem]()
    
    @IBOutlet var textbookOption: UIButton!
    @IBOutlet var furnitureOption: UIButton!
    
    @IBOutlet var newOption: UIButton!
    @IBOutlet var usedOption: UIButton!
    
    var itemCategorySelected : String = ""
    var itemConditionSelected : String = ""
    
    
    @IBOutlet var searchTextBox: UISearchBar!
    
    var searchText : String = ""
    
    
    @IBAction func textbookOptionClicked(_ sender: UIButton) {
        
        print("TextBook selected!")
        textbookOption.setImage(UIImage(named: "textbook-button-selected.png"), for: .normal)
        furnitureOption.setImage(UIImage(named: "furniture-button-unselected.png"), for: .normal)
        itemCategorySelected = "Textbook"
    }
    
    
    @IBAction func furnitureOptionClicked(_ sender: UIButton) {
        
        furnitureOption.setImage(UIImage(named: "furniture-button-selected.png"), for: .normal)
        textbookOption.setImage(UIImage(named: "textbook-button-unselected.png"), for: .normal)
        itemCategorySelected = "Furniture"
        
    }
    
    @IBAction func newOptionClicked(_ sender: UIButton) {
        
        newOption.setImage(UIImage(named: "new-button-selected.png"), for: .normal)
        usedOption.setImage(UIImage(named: "used-button-unselected.png"), for: .normal)
        itemConditionSelected = "New"
    }
    
    
    @IBAction func usedOptionClicked(_ sender: UIButton) {
        
        usedOption.setImage(UIImage(named: "used-button-selected.png"), for: .normal)
        newOption.setImage(UIImage(named: "new-button-unselected.png"), for: .normal)
        itemConditionSelected = "Used"
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    // seed data
    var sampleItemData = SampleItemData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        checkIfUserIsLoggedIn()
        
       
        //var publicItems = PublicItems()
        //fetchPublicItems()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        print("searchButton clicked!")
        
        
        //print(sampleItemData.items)
        
        //getSearchedItems()
        //getSearchResults(itemCategory: itemCategorySelected, itemCondition: itemConditionSelected)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "SearchItemViewToResultsTableView")
        {
            // create a variable to send
            //var sampleItemData = SampleItemData()
        
        
            let navigationController = segue.destination as! UINavigationController
            let searchResultTableViewController = navigationController.topViewController as! SearchResultTableViewController
            
            //let searchResults = fetchData()
            
            //print("--- Passing data---")
            //print(searchResults)
            //print("--- ---")
        
            searchResultTableViewController.publicItems = getSearchResults(itemCategory: itemCategorySelected, itemCondition: itemConditionSelected)
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
    
    func checkIfUserIsLoggedIn()
    {
        if FIRAuth.auth()?.currentUser?.uid == nil
        {
            dismiss(animated: true, completion: nil)
        }
        else
        {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
                
                (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]
                {
                    print(dictionary["email"] as? String)
                }
                
                
            }, withCancel: nil)
                
            
        
        }
    }
    
    
    func getItems()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let publicItemsRef = FIRDatabase.database().reference().child("publicItems")
        publicItemsRef.observe(.childAdded, with: {
            (snapshot) in
            
            
            print("SNAPSHOT")
            print(snapshot)
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                
                
                let publicItem = PublicItem()
                
                publicItem.userId = dictionary["userId"] as! String
                print(publicItem.userId)
                
                if uid != publicItem.userId
                {
                    
                    // crashes if the key does not match those in firebase
                    publicItem.name = dictionary["itemName"] as! String
                    publicItem.itemDescription = dictionary["itemDescription"] as! String
                    publicItem.type = dictionary["itemType"] as! String
                    publicItem.condition = dictionary["itemCondition"] as! String
                    publicItem.price = Double(dictionary["itemPrice"] as! String)!
                    publicItem.itemImageUrl = dictionary["itemImageUrl"] as! String
                    
                    publicItem.createdDate = dictionary["createdDate"] as! String
                    publicItem.userItemId = snapshot.key
                    
                    
                    
                    //print(publicItem)
                    
                    self.publicItems.append(publicItem)
                    
                    //print(self.publicItems)
                    /*
                    DispatchQueue.main.async(execute: {
                        
                        self.tableView.reloadData()
                    })
                    */
                }
                
            }
            
            print(snapshot)
            
        }, withCancel: nil)
    }
    
    func getSearchResults(itemCategory : String, itemCondition : String) -> [PublicItem]
    {
        print(itemCategory)
        print(itemCondition)
        print("GETTING RESULT")
        
        var searchTextItems = [PublicItem]()
        
        let searchInput = searchTextBox.text!
        
        
        
        
        
        
        
        var resultItems = [PublicItem]()
        
        var searchBuffer = [PublicItem]()
        
        // if search text is present, find all the items that match
        
        if !searchInput.isEmpty
        {
            for item in publicItems
            {
                if item.name == searchInput
                {
                    searchBuffer.append(item)
                }
            }
            
            for item in searchBuffer
            {
                if !itemCategory.isEmpty && itemCondition.isEmpty
                {
                    if item.type == itemCategory
                    {
                        print(item.name)
                        resultItems.append(item)
                    }
                    
                }
                else if itemCategory.isEmpty && !itemCondition.isEmpty
                {
                    if item.condition == itemCondition
                    {
                        print(item.name)
                        resultItems.append(item)
                    }
                    
                }
                else if !itemCategory.isEmpty && !itemCondition.isEmpty
                {
                    if item.type == itemCategory && item.condition == itemCondition
                    {
                        print(item.name)
                        resultItems.append(item)
                    }
                    
                }
                else
                {
                    return searchBuffer
                }
            }
            return resultItems
        }
            
            
            
        for item in publicItems
        {
            if !itemCategory.isEmpty && itemCondition.isEmpty
            {
                if item.type == itemCategory
                {
                    print(item.name)
                    resultItems.append(item)
                }

            }
            else if itemCategory.isEmpty && !itemCondition.isEmpty
            {
                if item.condition == itemCondition
                {
                    print(item.name)
                    resultItems.append(item)
                }

            }
            else if !itemCategory.isEmpty && !itemCondition.isEmpty
            {
                if item.type == itemCategory && item.condition == itemCondition
                {
                    print(item.name)
                    resultItems.append(item)
                }

            }
            else
            {
                return self.publicItems
            }
            //return resultItems
        }

        
        return resultItems
        print("--- ---")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
         getItems()
    }

}
