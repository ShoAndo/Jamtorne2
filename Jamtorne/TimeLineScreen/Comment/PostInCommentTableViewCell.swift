//
//  PostInCommentTableViewCell.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/04.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

class PostInCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    private var currentUserDidLike: Bool = false
    
    var post: Post!{
        didSet{
            updateUI()
        }
    }
    
    
    func updateUI(){
        let profileURL = URL(string: post.user.profileImage)
        var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
        do{
            let photoData = try Data(contentsOf: profileURL!)
            photoImage = UIImage(data: photoData)!
            
        }catch{
            print(error.localizedDescription)
        }
        userProfileImage.image! = photoImage
//        userProfileImage.image! = post.user.profileImage
        userName.text! = post.user.fullName
        createdAt.text! = post.createdAt
        
        let musicImageURL = URL(string: post.musicImage)
        var songImage: UIImage = UIImage(named:"musicImage")!
        do{
            let musicData = try Data(contentsOf: musicImageURL!)
            songImage = UIImage(data: musicData)!
        }catch{
            print(error.localizedDescription)
        }
        musicImage.image! = songImage
        artistName.text! = post.artistName
        songName.text! = post.songName
        postText.text! = post.postText
        
        likeButton.setTitle("\(post.numberOfLikes)いいね!", for: .normal)
        
        changeLikeButtonColor()
    }
    override func layoutSubviews() {
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
    }
    
    private func changeLikeButtonColor(){
        if currentUserDidLike{
            likeButton.tintColor = .red
        }else{
            likeButton.tintColor = .lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didClickLikeButton(_ sender: Any) {
        
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
}
