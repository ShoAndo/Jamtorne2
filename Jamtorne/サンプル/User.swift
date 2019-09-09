//
//  User.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

struct User {
    
    var id: String
    var fullName: String
    var email: String
    var profileImage: UIImage!
    var profileHeaderImage: UIImage!
    var interestId = [String]()
    
    init(id: String, fullName: String, email: String, profileImage: UIImage, headerImage: UIImage!) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
        self.profileHeaderImage = headerImage
    }
    
    // MARK: - Private
    
    static func allUsers() -> [User]
    {
        return [
            User(id: "f1", fullName: "Steave Jobs", email: "steave@info.com", profileImage: UIImage(named: "f1")!, headerImage: UIImage(named: "f1")!),
            User(id: "f2", fullName: "Mark", email: "mark@info.com", profileImage: UIImage(named: "f2")!, headerImage: UIImage(named: "f2"))
        ]
    }
    
    
}
