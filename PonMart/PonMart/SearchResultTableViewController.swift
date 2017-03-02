//
//  SearchResultTableViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/7/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SearchResultTableViewController: UITableViewController {
    
    
    var publicItems = [PublicItem]()
    
    @IBAction func backToSearchController(_ sender: Any) {
        
        print("Back pressed")
    }
    
    
    
    var items : [Any] = []
    var item : NSManagedObject? = nil
    var itemIndex : Int? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ResultTableViewToDetailView")
        {
            var itemDetailViewController = segue.destination as! ItemDetailViewController
            
            
            itemIndex = tableView.indexPathForSelectedRow?.row
            
            print("--- Item ---")
            //print(items[itemIndex!])
            print("--- ---")
            itemDetailViewController.item = publicItems[itemIndex!]
            
        }
        else
        {
            let navigationController = segue.destination as! SearchItemController
            //let searchViewController = navigationController.popViewController(animated: true)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(items)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        fetchPublicItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return publicItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        // Configure the cell...
        //itemNameLabel.text = items[0].name
        
        let publicItem = publicItems[indexPath.row]
        
        
        cell.itemNameLabel.text = publicItem.name
        print(cell.itemNameLabel.text)
        cell.priceLabel.text = "$\(publicItem.price)"
        
        
        if publicItem.condition == "New"
        {
            cell.conditionImage.image = UIImage(named: "new-label.png")!
        }
        else
        {
            //cell.conditionImage.image.frame.size.width = 100
            cell.conditionImage.image = UIImage(named: "used-label.png")!
            
        }
        
        
        let itemImageUrl = publicItem.itemImageUrl
        
        
        let url = NSURL(string: itemImageUrl)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {
            (data, response, error) in
            
            // download hit an error so we will return 
            if error != nil
            {
                print(error)
                return
            }
            
            DispatchQueue.main.async( execute: {
                 cell.itemImage.image = UIImage(data: data!)
            })
            
            
        }).resume()
        

        
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
        /*
        if let itemName = (item as AnyObject).value(forKey: "itemName") as? String
        {
            print(itemName)
            cell.itemNameLabel.text = itemName
        }
        if let itemImage = (item as AnyObject).value(forKey: "itemImage") as? NSData
        {
            cell.itemImage.image = UIImage(data: itemImage as Data)
        }
        
        /*
        print("--- ---")
        print(item)
        print("--- ---")
        */
        
         
        if let itemPrice = (item as AnyObject).value(forKey: "itemPrice") as? Double
        {
            cell.priceLabel.text = "$\(itemPrice)"
        }
        
    
        */
        
        //cell.priceLabel.text = "$\(item.price)"
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        performSegue(withIdentifier: "ResultTableViewToDetailView", sender: self)
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
     */
    
    
    func fetchPublicItems()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("publicItems").observe(.childAdded, with: {
            (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                
                
                let publicItem = PublicItem()
                publicItem.userId = dictionary["userId"] as! String
                
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
                    DispatchQueue.main.async(execute: {
                        
                        self.tableView.reloadData()
                    })
                }
                
            }
        
            print(snapshot)
                
        }, withCancel: nil)
    }
    
    
    
    
    
    
    
    
    
    
 

}
