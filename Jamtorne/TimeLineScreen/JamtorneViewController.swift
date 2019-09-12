//
//  JamtorneViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/11.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class JamtorneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            performSegue(withIdentifier: "toLogin", sender: nil)
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }

    
    

   
}
