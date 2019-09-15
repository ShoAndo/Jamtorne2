//
//  JamtorneViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/11.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseFirestore

class JamtorneViewController: UIViewController {
    
    var users:[User] = []

    override func viewDidLoad(){
        super.viewDidLoad()
        let db = Firestore.firestore()
        //        変数だから小文字にしておく
        db.collection("User").addSnapshotListener { (querySnapshot, error) in
            //            querySnapshotの中にはroomに中の全データが入っている
            guard let documents = querySnapshot?.documents else{
                //                roomの中に何もない場合、処理を中断
                return
            }
            //            登録をしているから一回登録するだけでオッケー
            //            全件のデータをroomの中に入れ直している
            //            扱いやすくするため
            //            変数documentsにroomの全データがあるので
            //            それを元に配列を作成し、画面を更新する
            //            documentはnameやcreatedが入っている
            //            .get()で値取得  any が入る　キャストする realmでも？
            //            Roomを新しく作っている
            //            documentIDはよくわからん文字列のやつ
            var results: [User] = []
            for document in documents {
                let fullName = document.get("fullName") as! String
                let email = document.get("email") as! String
                let profileImage = document.get("profileImage")as! String
                let documentID = document.documentID
                let user = User(documentID: documentID, fullName: fullName, email: email, profileImage: profileImage)
                results.append(user)
            }
            //           変数roomを書き換える
            self.users = results
        }

        if Auth.auth().currentUser != nil {
            print(users)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "toNewPost") as! NewPostViewController
//          vc.documentId = users[].documentID
            print("ドキュメントIDは\(vc.documentId)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
            }
            
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }

    
    

   
}
