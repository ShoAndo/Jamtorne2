//
//  NewCommentViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/04.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class NewCommentViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var post: Post!
    var user = Auth.auth().currentUser
//    var user = User.allUsers()[0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = ""
        textView.becomeFirstResponder()
        let profileURL = URL(string: (user?.photoURL!.absoluteString)!)
        var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
        do{
            let photoData = try Data(contentsOf: profileURL!)
            photoImage = UIImage(data: photoData)!
            
        }catch{
            print(error.localizedDescription)
        }
        userProfileImage.image! = photoImage
//        userProfileImage.image! = user.profileImage
//        userName.text! = user.fullName
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
