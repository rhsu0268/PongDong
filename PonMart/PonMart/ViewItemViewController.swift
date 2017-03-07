//
//  ViewItemViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/12/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class ViewItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var userProfileImage: UIImageView!
    
    var userItems = [UserItem]()
    
    var items: [String] = ["We", "Heart", "Swift"]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        //tableView.allowsSelection = false
        
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        self.userProfileImage.image = nil
        
        getUserProfileImage()
        
        // Do any additional setup after loading the view.
        
        fetchUserItems()
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(3)
        return self.userItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserItemCell
        
        let item = userItems[indexPath.row]
        //print(item)
        cell.itemName.text = item.itemName
        cell.itemType.text = item.itemCategory
        cell.itemCondition.text = item.itemCondition
        cell.itemPrice.text = "$\(item.itemPrice)"
        cell.itemDescription.text = item.itemDescription
        
        print("---")
        print(item.publicOrPrivate)
        print("---")
        if (item.publicOrPrivate)
        {
            // public
            cell.itemStatus.text = "Public"
        }
        else
        {
            cell.itemStatus.text = "Private"
        }
        
        let itemImageUrl = item.itemImageUrl
        
        cell.itemImage.loadImageUsingCacheWithUrlString(urlString: itemImageUrl)
    
        
        /*
        let itemImageUrl = item.itemImageUrl
        
        
        
        
        
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
        */
        

        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        
        print("You selected cell #\(indexPath.row)!")
        let item = userItems[indexPath.row]
        
        print("---IndexPath---")
        print(type(of: indexPath))
        if (item.publicOrPrivate)
        {
            // make item private
            displayMakePublicAlertMessage(userMessage: "Would you like to make this item Private?", createdDate: item.createdDate, itemCondition: item.itemCondition, itemDescription: item.itemDescription, itemImageUrl: item.itemImageUrl, itemName: item.itemName, itemPrice: String(item.itemPrice), itemType: item.itemCategory, itemId: item.itemId, itemStatus: item.publicOrPrivate, indexPath : indexPath)
            


            
        }
        else
        {
            displayMakePublicAlertMessage(userMessage: "Would you like to make this item Public?", createdDate: item.createdDate, itemCondition: item.itemCondition, itemDescription: item.itemDescription, itemImageUrl: item.itemImageUrl, itemName: item.itemName, itemPrice: String(item.itemPrice), itemType: item.itemCategory, itemId: item.itemId, itemStatus: item.publicOrPrivate, indexPath : indexPath)
            
        }
        

        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit")
        {
            action, index in
            
            
           
            self.performSegue(withIdentifier: "ViewItemViewToEditItemView", sender: self)
            print("Edit button tapped")
        }
        edit.backgroundColor = .orange
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete")
        {
            action, index in
            print("Delete button tapped")
            
            
        }
        delete.backgroundColor = .red
        
        return [edit, delete]
    }
    
    func fetchUserItems()
    {
        userItems = []
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("userItems").child(uid!).observe(.childAdded, with: {
            (snapshot) in
            print(snapshot.key)
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                print(dictionary)
            
                let userItem = UserItem()
                
                // crashes if the key does not match those in firebase
                userItem.itemName = dictionary["itemName"] as! String
                userItem.itemDescription = dictionary["itemDescription"] as! String
                userItem.itemCategory = dictionary["itemCategory"] as! String
                userItem.itemCondition = dictionary["itemCondition"] as! String
                userItem.itemPrice = Double(dictionary["itemPrice"] as! String)!
                userItem.itemImageUrl = dictionary["itemImageURL"] as! String
                userItem.createdDate = dictionary["createdDate"] as! String
                userItem.updatedDate = dictionary["updatedDate"] as! String
                userItem.itemId = snapshot.key
                userItem.publicOrPrivate = dictionary["publicOrPrivate"] as! BooleanLiteralType
                //publicItem.userId = dictionary["userId"] as! String
                //publicItem.createdDate = dictionary["createdDate"] as! String
                
                print(userItem)
                
                self.userItems.append(userItem)
                
                DispatchQueue.main.async(execute: {
                    
                    self.tableView.reloadData()
                })
                
            }
            
            //print(snapshot)
            
        }, withCancel: nil)

    }
    
    func getUserProfileImage()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: {
            
            (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                print(dictionary["profileImageURL"] as? String)
                // check whether key exists
                if let keyExists = dictionary["profileImageURL"]
                {
                    let url = NSURL(string: (dictionary["profileImageURL"] as? String)!)
                    
                    URLSession.shared.dataTask(with: url as! URL, completionHandler: {
                        
                        (data, response, error) in
                        
                        // download hit an error so lets return out
                        if error != nil
                        {
                            print(error)
                            return
                        }
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.userProfileImage.image = UIImage(data: data!)
                            
                        })
                        
                    }).resume()
                }
                else
                {
                    // set a placeholder
                    self.userProfileImage.image = UIImage(named: "user-profile-placeholder")
                }
            }
            
            
        }, withCancel: nil)
        
    }

    
    
    func displayMakePublicAlertMessage(userMessage: String, createdDate : String, itemCondition : String, itemDescription : String, itemImageUrl : String, itemName : String, itemPrice : String, itemType : String, itemId : String, itemStatus : BooleanLiteralType, indexPath : IndexPath)
    {
        //print(createdDate)
        
        
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        {
            (action) in
            print("Making item public")
        
            if (itemStatus)
            {
                // remove the item from publicItems
                self.deletePublicItem(itemId: itemId)
                // make item private
                // update the status of the item
                let uid = FIRAuth.auth()?.currentUser?.uid
                FIRDatabase.database().reference().child("userItems").child(uid!).child(itemId).updateChildValues(["publicOrPrivate": false])
                
                self.displayAlertMessage(userMessage: "You successfully made the item private!")
                
                DispatchQueue.main.async(execute: {
                    
                    self.fetchUserItems()
                    //self.tableView.reloadData()
                    //let indexPath = self.tableView.indexPathForSelectedRow
                    //let currentCell = self.tableView.cellForRow(at: indexPath) as! UserItemCell
                    //currentCell.itemStatus.text = "Private"
                    
                })
            }
            else
            {
                self.makeItemPublic(createdDate: createdDate, itemCondition: itemCondition, itemDescription: itemDescription, itemImageUrl: itemImageUrl, itemName: itemName, itemPrice: itemPrice, itemType: itemType, itemId : itemId)
                
                // update the status of the item
                let uid = FIRAuth.auth()?.currentUser?.uid
                FIRDatabase.database().reference().child("userItems").child(uid!).child(itemId).updateChildValues(["publicOrPrivate": true])
                
                self.displayAlertMessage(userMessage: "You successfully made the item public!")
                
                DispatchQueue.main.async(execute: {
                    
                    self.fetchUserItems()
                    //self.tableView.reloadData()
                    //let indexPath = self.tableView.indexPathForSelectedRow
                    
                    //let currentCell = self.tableView.cellForRow(at: indexPath) as! UserItemCell
                    //currentCell.itemStatus.text = "Public"
                    
                })

            }
           
            
            
           
        }
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil)

        
        myAlert.addAction(noAction)
        myAlert.addAction(okayAction)
        
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func makeItemPublic(createdDate : String, itemCondition : String, itemDescription : String, itemImageUrl: String, itemName: String, itemPrice: String, itemType: String, itemId: String)
    {
        print(createdDate)
        let uid = FIRAuth.auth()?.currentUser?.uid

        let publicItemReference = FIRDatabase.database().reference().child("publicItems").child(itemId)
        
        //publicItemReference.updateChildValues(["itemName": itemName])
        //publicItemReference.updateChildValues(["itemDescription": itemDescription])
        //publicItemReference.updateChildValues(["itemType": itemType])
        //publicItemReference.updateChildValues(["itemCondition": itemCondition])
        //publicItemReference.updateChildValues(["itemPrice": itemPrice])
        //publicItemReference.updateChildValues(["createdDate": createdDate])
            
        //publicItemReference.updateChildValues(["userId": uid!])
            
        let date = Foundation.Date()
        let updatedDate = date.dateToString()
        print("Date")
        print(updatedDate)
            
        //publicItemReference.updateChildValues(["updatedDate": updatedDate])
        //publicItemReference.updateChildValues(["itemImageUrl": itemImageUrl])
        //publicItemReference.updateChildValues(["userItemId": itemId])
        
        
        let values = ["itemName": itemName, "itemDescription": itemDescription, "itemType": itemType, "itemCondition": itemCondition, "itemPrice": itemPrice, "createdDate": createdDate, "userId": uid!, "updatedDate": updatedDate, "itemImageUrl": itemImageUrl, "userItemId": itemId ]
        
        publicItemReference.updateChildValues(values) { (error, ref) in
            if error != nil
            {
                print(error)
                return
            }
        }

    }
    
    func displayAlertMessage(userMessage: String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        {
            (action) in
            print("Success")
            
            //makeItemPublic()
            
          
        }
        
       
        myAlert.addAction(okayAction)
        
        
        self.present(myAlert, animated: true, completion: nil)
    }


    
    func updateItemStatus()
    {
        // find the item 
        
    }
    
    func deletePublicItem(itemId : String)
    {
        print(itemId)
        let itemRef = FIRDatabase.database().reference()
        
        itemRef.child("publicItems").child(itemId).removeValue(
        completionBlock: {
            (error, ref) in
            
            if error != nil
            
            {
                print(error)
            }
        })
        print(itemRef)
        print("Public item removed!")
    }
    
    func deleteUserItem(itemId : String)
    {
        print(itemId)
        
    }
    
    
    
    @IBAction func MessagesButtonClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ViewItemViewToMessageView", sender: self)
    }
    
    

}
