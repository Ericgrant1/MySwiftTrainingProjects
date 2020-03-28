//
//  AuthViewController.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 11.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

// 5.
class AuthViewController: UIViewController {

    // 7.
    private var authenticationService: AuthenticationService!
    // 7.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authenticationService = SceneDelegate.shared().authenticationService // AuthenticationService() - 7.1
        view.backgroundColor = .white
        
    }

    @IBAction func signInButton(_ sender: UIButton) {
        authenticationService.wakeUpSession() // 7.2
    }
    
}
// 5.
