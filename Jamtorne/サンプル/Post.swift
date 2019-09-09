//
//  Post.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

struct Post{
    
    var id: String
    var user: User
    var createdAt: String
    var musicImage: UIImage!
    var artistName:String
    var songName: String
    // 写真がない可能性もある
    var postText: String
    var numberOfLikes: Int = 0
    
    var userDidLike = false
    
    // このIDはParseからデータを習得するときに必要
    let interestId: String
    
    init(postId: String, author: User, createdAt: String, musicImage: UIImage!,artistName: String,songName:String, postText: String, numberOfLikes: Int, interestId: String, userDidLike: Bool)
    {
        self.id = postId
        self.user = author
        self.createdAt = createdAt
        self.musicImage = musicImage      // なしでもOK
        self.artistName = artistName
        self.songName = songName
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.interestId = interestId
        self.userDidLike = userDidLike
    }
    
    //Sampleデータ
    static let allPosts = [
        Post(postId: "s4", author: User.allUsers()[1], createdAt: "Today", musicImage: UIImage(named: "edsheeran")!,artistName:"Ed Sheeran", songName: "Galway Girl", postText: "一番好き", numberOfLikes: 12, interestId: "i1", userDidLike: true),
        Post(postId: "s2", author: User.allUsers()[0], createdAt: "Today", musicImage: UIImage(named: "kinokoteikoku2")!,artistName: "きのこ帝国", songName: "春と修羅", postText: "高校時代を思い出すな〜", numberOfLikes: 12, interestId: "i2", userDidLike: true),
        Post(postId: "s3", author: User.allUsers()[1], createdAt: "Yesterday", musicImage: UIImage(named: "indigolaend")!,artistName: "indigo la End", songName: "夏夜のマジック", postText: "夏の夜にはこれしか聞かない", numberOfLikes: 16, interestId: "i4", userDidLike: true),
        Post(postId: "s6", author: User.allUsers()[0], createdAt: "2 Days ago", musicImage: UIImage(named: "kinokoteikoku")!,artistName: "きのこ帝国", songName: "ロング　グッバイ", postText: "悲しくなったら聴く曲", numberOfLikes: 99, interestId: "t2", userDidLike: true),
    ]

    
}
