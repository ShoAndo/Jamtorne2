//
//  PostTableTableViewCell.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

protocol PostTableTableViewCellDelegate {
    func didClickCommentButton(post: Post)
}


class PostTableTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    private var currentUserDidLike: Bool = false
    
    var delegate: PostTableTableViewCellDelegate!
    
    var post: Post!{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        musicImage.layer.cornerRadius = 5.0
//        画像の変更を許可
        userProfileImage.clipsToBounds = true
        musicImage.clipsToBounds = true
        
        userProfileImage.image! = post.user.profileImage
        userName.text! = post.user.fullName
        createdAt.text! = post.createdAt
        musicImage.image! = post.musicImage
        artistName.text! = post.artistName
        songName.text! = post.songName
        postText.text! = post.postText
        likeButton.setTitle("\(post.numberOfLikes)いいね!", for: .normal)
        changeLikeButtonColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func changeLikeButtonColor(){
        if currentUserDidLike{
            likeButton.tintColor = .red
        }else{
            likeButton.tintColor = .lightGray
        }
    }
    
    @IBAction func didClickLikeButton(_ sender: UIButton) {
        currentUserDidLike = post.userDidLike
        if currentUserDidLike{
            post.numberOfLikes += 1
        }else{
            post.numberOfLikes -= 1
        }
        likeButton.setTitle("\(post.numberOfLikes)いいね!", for: .normal)
        changeLikeButtonColor()
        post.userDidLike = !post.userDidLike
        
    }
    @IBAction func didClickCommentButton(_ sender: Any) {
        
        delegate?.didClickCommentButton(post: post)
        
        
    }
}
