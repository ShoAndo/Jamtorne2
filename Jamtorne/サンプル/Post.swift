//
//  Post.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Firebase

public struct Post{
    
    var documentId: String
//    var user: User
    var uid:String
    var createdAt: Timestamp!
    var musicImage: String
    var artistName:String
    var songName: String
    // 写真がない可能性もある
    var postText: String
    var numberOfLikes: Int = 0
    
    var userDidLike = false
    
    // このIDはParseからデータを習得するときに必要
    let interestId: String
    
    init(documentId: String, uid: String, createdAt: Timestamp, musicImage: String,artistName: String,songName:String, postText: String, numberOfLikes: Int, interestId: String, userDidLike: Bool)
    {
        self.documentId = documentId
//        self.user = author
        self.uid = uid
        self.createdAt = createdAt
        self.musicImage = musicImage
        self.artistName = artistName
        self.songName = songName
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.interestId = interestId
        self.userDidLike = userDidLike
    }
    
    //Sampleデータ
/*    static let allPosts = [
        Post(documentId: "s4", author: User.allUsers()[1],uid: "aaa", createdAt: "Today", musicImage: "https://cdn.tower.jp/za/o/39/190295859039.jpg",artistName:"Ed Sheeran", songName: "Galway Girl", postText: "一番好き", numberOfLikes: 12, interestId: "i1", userDidLike: true),
        Post(documentId: "s2", author: User.allUsers()[0],uid: "aaa", createdAt: "Today", musicImage: "https://images-na.ssl-images-amazon.com/images/I/91s%2B9Buc9UL._SY355_.jpg",artistName: "きのこ帝国", songName: "春と修羅", postText: "高校時代を思い出すな〜", numberOfLikes: 12, interestId: "i2", userDidLike: true),
        Post(documentId: "s3", author: User.allUsers()[1],uid: "aaa", createdAt: "Yesterday", musicImage:"https://images-fe.ssl-images-amazon.com/images/I/51A38iYhrXL.jpg" ,artistName: "indigo la End", songName: "夏夜のマジック", postText: "夏の夜にはこれしか聞かない", numberOfLikes: 16, interestId: "i4", userDidLike: true),
        Post(documentId: "s6", author: User.allUsers()[0],uid: "aaa", createdAt: "2 Days ago", musicImage:"https://images-na.ssl-images-amazon.com/images/I/813IVul9UVL._SL1500_.jpg" ,artistName: "きのこ帝国", songName: "ロング　グッバイ", postText: "悲しくなったら聴く曲", numberOfLikes: 99, interestId: "t2", userDidLike: true),
    ]
 */

    
}
