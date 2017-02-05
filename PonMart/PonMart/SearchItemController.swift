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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    // seed data
    var sampleItemData = SampleItemData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        checkIfUserIsLoggedIn()
        
        getItems()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        print("searchButton clicked!")
        
        //print(sampleItemData.items)
        
       
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "SearchItemViewToResultsTableView")
        {
            // create a variable to send
            //var sampleItemData = SampleItemData()
        
        
            let navigationController = segue.destination as! UINavigationController
            let searchResultTableViewController = navigationController.topViewController as! SearchResultTableViewController
            
            let searchResults = fetchData()
            
            //print("--- Passing data---")
            //print(searchResults)
            //print("--- ---")
        
            searchResultTableViewController.items = searchResults
        }
    }

    
    
    func fetchData() -> [Any]
    {
        // Do any additional setup after loading the view.
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                sampleItemData.storedItems = results
                //print(sampleItemData.storedItems)
                /*
                 for result in results as! [NSManagedObject]
                 {
                 print(result)
                 if let itemName = result.value(forKey: "itemName") as? String
                 {
                 print(itemName)
                 }
                 
                 if let itemPrice = result.value(forKey: "itemPrice") as? Double
                 {
                 print(itemPrice)
                 }
                 }
                 */
            }
            
        }
        catch
        {
            // process error
        }
        return sampleItemData.storedItems

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
        // let users = [User]()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            // if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
            /*
            let user = User()
            if let dictionary = snapshot.value as? [String : AnyObject]
            
            {
             
                user.setValuesForKeysWithDictionary(dictionary)
                users.append(user
             
                // safer way
                user.name = dictionary["name"]
                print(user.email)
            }
            */
            print("User found")
            print(snapshot)
            
        }, withCancel: nil)
    }

}
