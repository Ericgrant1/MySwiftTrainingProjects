//
//  ViewController.swift
//  MyTaskListFirebase
//
//  Created by Eric Grant on 28.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit
import Firebase

// В проекте следуем архитектуре MVC
class LoginViewController: UIViewController {
    
    // 10.1
    let segueID = "tasksSegue"
    // 10.1
    // 20.
    var ref: DatabaseReference!
    // 20.
    
    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 20.1
        ref = Database.database().reference(withPath: "users")
        // 20.1
        // 3.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // 3.
        // 6.1
        notifyLabel.alpha = 1
        // 6.1
        
        // 10.
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
            }
        }
        // 10.
    }
    
    // 12.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mailTextField.text = ""
        passwordTextField.text = "" 
    }
    // 12.
    
    // 4.
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyboardSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    // 4.
    
    // 6.
    func displayNotifylabel(withText text: String) {
        notifyLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: { [ weak self] in
            self?.notifyLabel.alpha = 1
        }) { [weak self] complete in
            self?.notifyLabel.alpha = 0
        }
    }
    // 6.

    @IBAction func loginAction(_ sender: UIButton) {
        // 5.
        guard let email = mailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            // 7.
            displayNotifylabel(withText: "Incorrect data")
            return
            // 7.
        }
        // 5.
        // 8.
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.displayNotifylabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            
            self?.displayNotifylabel(withText: "No such user")
        }
        // 8.
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        // 9.
        guard let email = mailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayNotifylabel(withText: "Incorrect data")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // 19.
//            if error == nil {
//                if user != nil {
//                    // self?.performSegue(withIdentifier: "tasksSegue", sender: nil) - удаляем
//                } else {
//                    print("User is not created")
//                }
//            } else {
//                print(error!.localizedDescription)
//            }
            guard error == nil, authResult != nil else {

                print(error!.localizedDescription)
                return
            }
            // 19.
            // 21.
            let userRef = self.ref.child((authResult?.user.uid)!)
            userRef.setValue(["email": authResult?.user.email])
            // 21.
        }
        // 9.
    }
}

