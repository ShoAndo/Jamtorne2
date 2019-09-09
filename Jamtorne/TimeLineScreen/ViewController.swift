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


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post = Post.allPosts
    let cloudServiceController = SKCloudServiceController()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
       
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        title = "Jamtorne"
        
        createButton()
        
    }
    
    private func createButton(){
        let floaty = Floaty()
        floaty.addItem("post", icon: UIImage(named: "posticon2")!, handler: {item in
            self.performSegue(withIdentifier: "toNewPost", sender: nil)
        })
        self.view.addSubview(floaty)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComment"{
            let vc = segue.destination as! CommentViewController
            vc.post = sender as? Post
        }
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableTableViewCell
        cell.post = post[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ViewController: PostTableTableViewCellDelegate{
    func didClickCommentButton(post: Post) {
        self.performSegue(withIdentifier: "toComment", sender: post)
    }
}

