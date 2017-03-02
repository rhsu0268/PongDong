//
//  ChatUserCell.swift
//  PonMart
//
//  Created by Richard Hsu on 2/26/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class UserSellingItemCell: UITableViewCell {
    
    var message : Message?
    {
        didSet
        {
            
            
            // check the message and make sure that you are using the right person 
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            let fromId = message?.fromId
            let toId = message?.toId
            
            
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
                    
                    //self.userItems.append(userItem)
                    
                    self.textLabel?.text = userItem.itemName
                }
                
                //print(snapshot)
                
            }, withCancel: nil)
            
            /*
            if uid == fromId  {
                
                
                let toUserRef = FIRDatabase.database().reference().child("users").child(toId!)
                
                toUserRef.observe(.value, with: {
                    (snapshot) in
                    if let dictionary = snapshot.value as? [String : AnyObject]
                    {
                        self.textLabel?.text = dictionary["email"] as? String
                        
                        
                        
                        if let profileImageUrl = dictionary["userImage"] as? String
                        {
                            //user.userImage = image
                            print("image exsits")
                            self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl )
                            
                        }
                        else
                        {
                            print("image does not exist!")
                            self.profileImageView.image = UIImage(named: "user-profile-placeholder")
                        }
                        
                    }
                    
                    
                }, withCancel: nil)
            }
            
            else
            {
                let toUserRef = FIRDatabase.database().reference().child("users").child(fromId!)
                
                toUserRef.observe(.value, with: {
                    (snapshot) in
                    if let dictionary = snapshot.value as? [String : AnyObject]
                    {
                        self.textLabel?.text = dictionary["email"] as? String
                        
                        
                        
                        if let profileImageUrl = dictionary["userImage"] as? String
                        {
                            //user.userImage = image
                            print("image exsits")
                            self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl )
                            
                        }
                        else
                        {
                            print("image does not exist!")
                            self.profileImageView.image = UIImage(named: "user-profile-placeholder")
                        }
                        
                    }
                    
                    
                }, withCancel: nil)

            }
             */
            //detailTextLabel?.text = message?.text
            
            
            //timeLabel.text = message?.timestamp

        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 1, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        //profileImage
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // Configure the view for the selected state
        addSubview(profileImageView)
        addSubview(timeLabel)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        // need x, y, width, height, anchors
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        

    }

}
