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
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchChatUsers()
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
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        //print(user)
        print(user.userImage)
        print(user.userEmail)
        cell.userName.text = user.userEmail
        
        if user.userImage == "nil"
        {
            cell.userImage.image = UIImage(named: "user-profile-placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //
        
        print("You selected cell #\(indexPath.row)!")
        //let item = userItems[indexPath.row]
        performSegue(withIdentifier: "UserMessageViewToChatView", sender: self)
        
    }
    
    func fetchChatUsers()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {
            (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                
                
                let user = User()
                //publicItem.userId = dictionary["userId"] as! String
                
                //if uid != publicItem.userId
                //{
                    
                    // crashes if the key does not match those in firebase
                    user.userEmail = dictionary["email"] as! String
                
                
                    // get the image if it exists
                    if let image = dictionary["userImage"] as? String
                    {
                        user.userImage = image
                    }
                    else
                    {
                        user.userImage = "nil"
                    }
                    //publicItem.itemDescription = dictionary["itemDescription"] as! String
                    //publicItem.type = dictionary["itemType"] as! String
                    //publicItem.condition = dictionary["itemCondition"] as! String
                    //publicItem.price = Double(dictionary["itemPrice"] as! String)!
                    //publicItem.itemImageUrl = dictionary["itemImageUrl"] as! String
                    
                    //publicItem.createdDate = dictionary["createdDate"] as! String
                    
                    //print(publicItem)
                    
                    self.users.append(user)
                    
                    //print(self.publicItems)
                    DispatchQueue.main.async(execute: {
                        
                        self.tableView.reloadData()
                    })
                }
                
            //}
            
            print(snapshot)
            
        }, withCancel: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // UserMessageViewToChatView"
        if (segue.identifier == "UserMessageViewToChatView")
        {
            var navigationController = segue.destination as! UINavigationController
            
            
            var chatMessageViewControler = navigationController.topViewController as! ChatMessageViewController
            
            var userIndex = tableView.indexPathForSelectedRow?.row
            
           
            //print(items[itemIndex!])
            chatMessageViewControler.user = users[userIndex!]
            
        }

    }

}
