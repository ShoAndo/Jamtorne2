//
//  NewCommentViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/04.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var post: Post!
    var user = User.allUsers()[0]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = ""
        textView.becomeFirstResponder()
        userProfileImage.image! = user.profileImage
        userName.text! = user.fullName
        
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2
        
      
        

    }
    
    @IBAction func didClickBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        textView.resignFirstResponder()
    }
    
    @IBAction func didClickCommentButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        textView.resignFirstResponder()
    }
    

}
