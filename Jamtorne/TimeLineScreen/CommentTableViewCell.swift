//
//  CommentTableViewCell.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/04.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    var comment: Comment!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        userProfileImage.image! = comment.user.profileImage
        userNameLabel.text! = comment.user.fullName
        createdAt.text! = comment.createdAt
        commentText.text! = comment.commentText
        
    }
    override func layoutSubviews() {
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
