//
//  UserMessageViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/23/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class UserMessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["We", "Heart", "Swift"]
    
    var users: [User] = []
    
    var userItems = [UserItem]()
    
    
    let cellId = "cellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fetchChatUsers()
        
        tableView.register(UserSellingItemCell.self, forCellReuseIdentifier: cellId)
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
        return self.userItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        /*
        let user = users[indexPath.row]
        //print(user)
        print(user.userImage)
        print(user.userEmail)
        cell.userName.text = user.userEmail
        
        if user.userImage == "nil"
        {
            cell.userImage.image = UIImage(named: "user-profile-placeholder")
        }
        */
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserSellingItemCell
        let userItem = userItems[indexPath.row]
        
        cell.userItem = userItem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //
        
        print("You selected cell #\(indexPath.row)!")
        //let item = userItems[indexPath.row]
        performSegue(withIdentifier: "UserMessageViewToChatView", sender: self)
        
    }
    
    func fetchUserItems()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        //let fromId = message?.fromId
        //let toId = message?.toId
        
        
        // get the user's items
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
                
                //self.textLabel?.text = userItem.itemName
            }
            
            //print(snapshot)
            
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
            chatMessageViewControler.userItem = userItems[userIndex!]
            
        }

    }
    

    
    func addMessage()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let messageRef = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        messageRef.updateChildValues(["toId": "1M5qiinnz6V85JPPgie7Yyjwt3E3"])
        messageRef.updateChildValues(["fromId": "VhY2lsIbUmd5363xHKvMvf9nBww1"])
        messageRef.updateChildValues(["text": "HELLO!"])
        messageRef.updateChildValues(["timestamp": "12:36 PM"])
        
        let newMessageRef = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        newMessageRef.updateChildValues(["toId": "1M5qiinnz6V85JPPgie7Yyjwt3E3"])
        newMessageRef.updateChildValues(["fromId": "VhY2lsIbUmd5363xHKvMvf9nBww1"])
        newMessageRef.updateChildValues(["text": "HELLO!"])
        newMessageRef.updateChildValues(["timestamp": "1:29 PM"])
        
        let newMessageRef2 = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        newMessageRef2.updateChildValues(["toId": "mpmxEUz4xwXvxXuzl0OF1kiOW4m2"])
        newMessageRef2.updateChildValues(["fromId": "VhY2lsIbUmd5363xHKvMvf9nBww1"])
        newMessageRef2.updateChildValues(["text": "HELLO!"])
        newMessageRef2.updateChildValues(["timestamp": "9:03 PM"])
        
    }


}
