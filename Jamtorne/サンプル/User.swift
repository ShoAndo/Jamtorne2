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
    var profileImage: String
    var uid: String
//    var profileHeaderImage: UIImage!
//    var interestId = [String]()
    
    init(documentID: String, fullName: String, email: String, profileImage: String, uid: String) {
        self.documentID = documentID
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
        self.uid = uid
//        self.profileHeaderImage = headerImage
    }
    
    // MARK: - Private
    
/*    static func allUsers() -> [User]
    {
        return [
            User(documentID: "f1", fullName: "Steave Jobs", email: "steave@info.com", profileImage:"https://lh3.googleusercontent.com/a-/AAuE7mBI5rCNiWIEiFcf4agRfowDsVq1di7Pc1IsRv_e=s96-c" ),
            User(documentID: "f2", fullName: "Mark", email: "mark@info.com", profileImage:"https://lh3.googleusercontent.com/a-/AAuE7mBI5rCNiWIEiFcf4agRfowDsVq1di7Pc1IsRv_e=s96-c" )
        ]
    }
 
    */
    
}
