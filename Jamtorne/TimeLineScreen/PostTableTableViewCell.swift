//
//  PostTableTableViewCell.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

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
    var user = Auth.auth().currentUser
    var post: Post!{
        didSet{
            updateUI()
        }
    }
    
    lazy var dateformatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        return dateformatter
    }()
    
    private func updateUI(){
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        musicImage.layer.cornerRadius = 5.0
//        画像の変更を許可
        userProfileImage.clipsToBounds = true
        musicImage.clipsToBounds = true
        
        let profileURL = URL(string: (user?.photoURL!.absoluteString)!)
        var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
        do{
            let photoData = try Data(contentsOf: profileURL!)
            photoImage = UIImage(data: photoData)!

        }catch{
            print(error.localizedDescription)
        }
        userProfileImage.image! = photoImage
        userName.text! = (user?.displayName)!
        createdAt.text! = dateformatter.string(from: post.createdAt!.dateValue())

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
