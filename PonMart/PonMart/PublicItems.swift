//
//  PublicItems.swift
//  PonMart
//
//  Created by Richard Hsu on 2/11/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import Firebase

class PublicItems
{
    //public var publicItems : [PublicItem]
    
    init()
    {
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let publicItemReference = FIRDatabase.database().reference().child("publicItems").childByAutoId()
        
        publicItemReference.updateChildValues(["itemName": "Sofa"])
        publicItemReference.updateChildValues(["itemDescription": "This is a great sofa."])
        publicItemReference.updateChildValues(["itemType": "Furniture"])
        publicItemReference.updateChildValues(["itemCondition": "Used"])
        publicItemReference.updateChildValues(["itemPrice": "6.99"])
        publicItemReference.updateChildValues(["userId": uid])
        
        let date = Foundation.Date()
        let formatedDate = date.dashedStringFromDate()
        print("Date")
        print(formatedDate)
        publicItemReference.updateChildValues(["createdDate": formatedDate])
        
        let key = publicItemReference.key
        print(key)
        
        let imageName = NSUUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("publicItem_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(UIImage(named:"sofa.jpeg")!)
        {
            storageRef.put(uploadData, metadata: nil, completion: {
                (metadata, error) in
                
                if error != nil
                {
                    print(error)
                    return
                }
                
                print(metadata)
                        
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    print(profileImageUrl)
                    
                    let itemReference = FIRDatabase.database().reference().child("publicItems").child(key)
                    
                    
                    itemReference.updateChildValues(["profileImageURL": profileImageUrl])
                }
                
                
            })
        }
    }
    
}

extension Foundation.Date {
    
    func dashedStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        let date = self
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
