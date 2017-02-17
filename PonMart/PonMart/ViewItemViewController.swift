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

        

        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit")
        {
            action, index in
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
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("userItems").child(uid!).observe(.childAdded, with: {
            (snapshot) in
            
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
                print(userItem.publicOrPrivate)
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

    
    
   
    

}
