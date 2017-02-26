//
//  ChatMessageViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 2/24/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Firebase

class ChatMessageViewController: UIViewController {
    
    //var user : User? = nil
    
    var user: User?
    {
        didSet
        {
            navigationItem.title = user?.userEmail
        }
    }
    /*
    let inputTextField = UITextField()
    inputTextField.placeholder = "Enter message..."
    inputTextField.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(inputTextField)
    */
    
    let inputTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user?.userEmail)

        // Do any additional setup after loading the view.
        setupInputComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "ChatViewToUserMessageView", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func setupInputComponents()
    {
        let containerView = UIView()
        //containerView.backgroundColor = UIColor.red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        
        // ios9 containt anchors
        // x, y, w, h
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        //x, y, w, h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        

        containerView.addSubview(inputTextField)
        //x, y, w, h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        //inputTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        
        // seperator 
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor.black
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        // x, y, w, h
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func handleSend()
    {
        print(inputTextField.text)
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let messageRef = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        let toId = user?.toId
        let date = Foundation.Date()
        let formatedDate = date.dateToString()
        let values = ["messages": inputTextField.text!, "toId": toId, "fromId": uid, "timestamp": formatedDate]
        //messageRef.child(uid!).updateChildValues(values)
        messageRef.updateChildValues(values)
    }
    
    
    func observeMessage()
    {
        let messageRef = FIRDatabase.database().reference().child("messages")
        messageRef.observe(.childAdded, with: {
            (snapshot) in
            
            print(snapshot)
            
        }, withCancel: nil)
    }

}
