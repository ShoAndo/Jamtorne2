//
//  User.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

struct User {
    
    var documentID: String
    var fullName: String
    var email: String
    var profileImage: UIImage!
//    var profileHeaderImage: UIImage!
//    var interestId = [String]()
    
    init(documentID: String, fullName: String, email: String, profileImage: UIImage) {
        self.documentID = documentID
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
//        self.profileHeaderImage = headerImage
    }
    
    // MARK: - Private
    
    static func allUsers() -> [User]
    {
        return [
            User(documentID: "f1", fullName: "Steave Jobs", email: "steave@info.com", profileImage: UIImage(named: "f1")!),
            User(documentID: "f2", fullName: "Mark", email: "mark@info.com", profileImage: UIImage(named: "f2")!)
        ]
    }
    
    
}
