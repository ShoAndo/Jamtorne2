//
//  CommentViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/04.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Floaty

class CommentViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var comment = Comment.allComments()
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        let nib1 = UINib(nibName: "PostInCommentTableViewCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "PostInCommentCell")
        
        let nib2 = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "commentCell")
        createButton()
    }
    
    func createButton(){
    
    let floaty = Floaty()
    floaty.addItem("comment", icon: UIImage(named: "posticon2")!, handler: {item in
    self.performSegue(withIdentifier: "toNewComment", sender: nil)
    })
    self.view.addSubview(floaty)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewComment"{
            let vc = segue.destination as! NewCommentViewController
            vc.post = post
        }
    }
   
}


extension CommentViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostInCommentCell", for: indexPath) as! PostInCommentTableViewCell
            cell.post = post
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
            cell.comment = comment[indexPath.row - 1]
            
            return cell
        }
    }
    
    
}
