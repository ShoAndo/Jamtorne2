//
//  ViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import StoreKit
import Floaty
import Firebase
import FirebaseFirestore


class ViewController: UIViewController {
    var posts:[Post] = []{
        didSet{
            tableView.reloadData()
            print(posts)
        }
    }
    
    var user : User!
    var documentId = ""
    var postDocumentId = ""
    @IBOutlet weak var tableView: UITableView!
    
//    var post = Post.allPosts
    let cloudServiceController = SKCloudServiceController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
       
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        title = "タイムライン"
      
        createButton()
        
    }
    
    private func createButton(){
        let floaty = Floaty()
        floaty.paddingX = CGFloat(8)
        floaty.paddingY = CGFloat(50)
        floaty.addItem("新規投稿", icon: UIImage(named: "postIcon2-1")!, handler: {item in
            self.performSegue(withIdentifier: "toNewPost", sender: nil)
        })
        self.view.addSubview(floaty)
        
    }
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComment"{
            let vc = segue.destination as! CommentViewController
            vc.post = sender as? Post
        }
    }
 */
    
    override func viewWillAppear(_ animated: Bool) {
      
        let db = Firestore.firestore()
        
  /*      db.collection("User").addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else{
                return
            }
            
            var results: [User] = []
            for document in documents{
                
                let email = document.get("email") as! String
                let fullName = document.get("fullName") as! String
                let profileImage = document.get("profileImage") as! String
                let uid = document.get("uid") as! String
                let documentId = document.documentID
                let user = User(documentID: documentId, fullName: fullName, email: email, profileImage: profileImage, uid: uid)
                results.append(user)
            }
            self.users = results
        }
        let currentUser = Auth.auth().currentUser
        
        for user in users {
            if currentUser!.uid == user.uid{
                self.user = user
            }
        }
 */
 
        
        db.collection("Post").addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else{
                return
            }
            
            var results: [Post] = []
            for document in documents {
                let artistName = document.get("artistName") as! String
                let createdAt = document.get("createdAt") as! Timestamp
                let interestId = document.get("interestId") as! String
                let musicImage = document.get("musicImage") as! String
                let numberOfLikes = document.get("numberOfLikes") as! Int
                let postText = document.get("postText") as! String
                let songName = document.get("songName") as! String
                let uid = document.get("uid") as! String
                let userDidLike = document.get("userDidLike") as! Bool
                let documentId = document.documentID
                let post = Post(documentId: documentId, uid: uid, createdAt: createdAt, musicImage: musicImage, artistName: artistName, songName: songName, postText: postText, numberOfLikes: numberOfLikes, interestId: interestId, userDidLike: userDidLike)
                results.append(post)
            }
            self.posts = results
            
        }
        
 /*       let db = Firestore.firestore()
        let defaults = UserDefaults.standard
        documentId = defaults.object(forKey: "documentId") as! String
        db.collection("User").getDocuments { (QuerySnapshot, error) in
            if error == nil, let snapshot = QuerySnapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    print(data)
                    let user = User(documentID: self.documentId, fullName: data["fullName"] as! String, email: data["email"] as! String, profileImage: data["profiliImage"] as! String)
                    self.user = user
                }
            }
        }
        
        

        guard postDocumentId == "" else{
            db.collection("User").document(documentId).collection("Post").getDocuments { (QuerySnapshot, error) in
                if error == nil, let snapshot = QuerySnapshot{
                    self.post = []
                    for document in snapshot.documents{
                        let data = document.data()
                        let post = Post(documentId: self.postDocumentId, author: self.user, uid: data["uid"] as! String, createdAt: data["createdAt"] as! String, musicImage: data["musicImage"] as! String, artistName: data["artistName"] as! String, songName: data["songName"] as! String, postText: data["postText"] as! String, numberOfLikes: data["numberOfLikes"] as! Int, interestId: data["interestId"] as! String, userDidLike: data["userDidLike"] as! Bool)
                        self.post.append(post)
                    }
                    self.tableView.reloadData()
                }
            }
            return
        }
    */
        
       
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableTableViewCell
        cell.post = posts[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ViewController: PostTableTableViewCellDelegate{
    func didClickCommentButton(post: Post) {
        self.performSegue(withIdentifier: "toComment", sender: post)
    }
}

