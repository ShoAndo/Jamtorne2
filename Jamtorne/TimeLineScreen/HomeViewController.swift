//
//  HomeViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/09.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    var post: [Post] = []
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var postCount: UIButton!
    @IBOutlet weak var followCount: UIButton!
    @IBOutlet weak var followerCount: UIButton!
    @IBOutlet weak var DMButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width/2
        profileImage.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        gertProfile()
    }
    
    func gertProfile(){
        let user = Auth.auth().currentUser
        if let user = user {
            let fullName = user.displayName!
            let photoURL = user.photoURL!
            var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
            do{
                let photoData = try Data(contentsOf: photoURL)
                photoImage = UIImage(data: photoData)!
            }catch{
                print(error.localizedDescription)
            }
            profileImage.image! = photoImage
            self.fullName.text! = fullName
        }
    }
    
    @IBAction func didClickDMButton(_ sender: Any) {
    }
    @IBAction func didClickFollowButton(_ sender: Any) {
    }
  
}
