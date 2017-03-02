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
    
    var messages = [Message]()
    var messagesDictionary = [String : Message]()
    
    let cellId = "cellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fetchChatUsers()
        
        tableView.register(UserSellingItemCell.self, forCellReuseIdentifier: cellId)
        //addMessage()
        groupMessage()
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
        return self.messages.count
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
        let message = messages[indexPath.row]
        
        cell.message = message
        
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
            
            print("---snapshot---")
            print(snapshot.key)
            print("--- ---")
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
                    user.toId = snapshot.key
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
            chatMessageViewControler.message = messages[userIndex!]
            
        }

    }
    
    func groupMessage()
    {
        let messageRef = FIRDatabase.database().reference().child("messages")
        messageRef.observe(.childAdded, with: {
            (snapshot) in
            
            //print(snapshot)
            if let dictionary = snapshot.value as? [String : AnyObject]
            {
                let message = Message()
                message.toId = dictionary["toId"] as! String?
                message.text = dictionary["text"] as! String?
                message.timestamp = dictionary["timestamp"] as! String?
                message.fromId = dictionary["fromId"] as! String?
                
                //print(message.text)
                let uid = FIRAuth.auth()?.currentUser?.uid
                print("---uid---")
                print(uid)
                print("--- ---")
                let toId = message.toId
                print("---toId---")
                print(toId)
                print("--- ---")
                let fromId = message.fromId
                print("---fromId---")
                print(fromId)
                print("--- ---")
                
                
                /*
                if let toId = message.toId
                {
                    print(toId)
                }
                if let fromId = message.fromId
                {
                    print(fromId)
                }
                */
                
                // ensure that the user is a sender or reciever
                if (toId! == uid! || fromId! == uid!)
                {
                    
                
                
                    // only show the messages from other people
                    if fromId! != uid
                    {
                        //print("---Messages---")
                        //print(self.messages)
                        //print("--- ---")
                        self.messagesDictionary[toId!] = message
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                        
                        
                            let dateFormatter = DateFormatter()
                            //dateFormatter.dateStyle = .short
                            dateFormatter.timeStyle = .short
                            let date1 = dateFormatter.date(from: message1.timestamp!)
                            //print(date1?.timeIntervalSince1970)
                            print(message2)
                            let date2 = dateFormatter.date(from: message2.timestamp!)
                            //print(date2?.timeIntervalSince1970)
                            return Int((date1?.timeIntervalSince1970)!) > Int((date2?.timeIntervalSince1970)!)
                        })
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.tableView.reloadData();
                })
                
            }
            
            
            
        }, withCancel: nil)
        
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
