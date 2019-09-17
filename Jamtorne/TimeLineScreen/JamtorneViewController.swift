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
import FirebaseFirestore

class JamtorneViewController: UIViewController {
    
    var users:[User] = []

    override func viewDidLoad(){
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
            }
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
}
