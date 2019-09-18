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
 
    override func viewWillAppear(_ animated: Bool) {
       displayTimeLine()
    }
    
    func displayTimeLine(){
        let db = Firestore.firestore()
        db.collection("Post").order(by: "createdAt").addSnapshotListener { (QuerySnapshot, error) in
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
            self.posts = results.reversed()
        }
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

