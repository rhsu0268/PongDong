//
//  UserMessageViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/23/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class UserMessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let user = items[indexPath.row]
        print(user)
        cell.userName.text = user
        
        return cell
    }
    
    func fetchChatUsers()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {
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
                    
                    print(publicItem)
                    
                    self.publicItems.append(publicItem)
                    
                    print(self.publicItems)
                    DispatchQueue.main.async(execute: {
                        
                        self.tableView.reloadData()
                    })
                }
                
            }
            
            print(snapshot)
            
        }, withCancel: nil)

    }

}
