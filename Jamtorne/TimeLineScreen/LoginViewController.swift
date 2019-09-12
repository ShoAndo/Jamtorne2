//
//  LoginViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/09/09.
//  Copyright © 2019 安藤奨. All rights reserved.
//


import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore

class LoginViewController: UIViewController {

   var documentID = ""
    var users: [Users] = []
    var user: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        let db = Firestore.firestore()
        
        //        変数だから小文字にしておく
        db.collection("Users").addSnapshotListener { (querySnapshot, error) in
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
            var results: [Users] = []
            for document in documents {
                let fullName = document.get("name") as! String
                let documentid = document.documentID
//                let users = Users(documentId: documentid, fullName: fullName)
                let users = Users(documentId: documentid, fullName: fullName)
                results.append(users)
            }
            //           変数roomを書き換える
            self.users = results
        }
        db.collection("Users").document(documentID).collection("User").order(by: "fullName", descending: true).addSnapshotListener { (querySnapshot, error) in
            //            querySnapshotの中にはroomに中の全データが入っている
            guard let documents = querySnapshot?.documents else{
                //                roomの中に何もない場合、処理を中断
                return
            }
        
            var result: [User] = []
            for document in documents {
                let fullName = document.get("fullName") as! String
                let email = document.get("email") as! String
                let profileImage = document.get("profileImage") as! UIImage
                let documentID = document.documentID
                
                let user = User(documentID: documentID, fullName: fullName, email: email, profileImage: profileImage)
                
                result.append(user)
                
            }
            
            
            //            変数roomを書き換える
            self.user = result
        }
 
   
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            performSegue(withIdentifier: "toTimeLine", sender: nil)
        } else {
            return
        }
    }
    
    
}
extension LoginViewController:GIDSignInDelegate, GIDSignInUIDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //        エラーの確認をする
        if let error = error{
            //            errorがnilでない場合（エラーがある場合）
            print("Google Sign Inでエラーが発生しました")
            //            エラーの情報を見る
            print(error.localizedDescription)
            return
        }
        //        googleのサインインの準備（トークンの取得）
        //        ユーザ情報取得
        //        もうえログイン済みでuserにはログイン情報が入っている
        let authentication = user.authentication
        
        //        googleトークンの取得
        let credential = GoogleAuthProvider.credential(withIDToken: authentication!.idToken, accessToken: authentication!.accessToken)
        
        // Googleでログインをする。Firebaseにログイン情報を書き込む
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            
            if let error = error {
                print("失敗")
                print(error.localizedDescription)
            } else {
                print("成功")
                let user = Auth.auth().currentUser
                if let user = user {
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    let documentId = ""
                    let fullName = user.displayName!
                    let email = user.email
                    let photoURL = user.photoURL!
                   
                    let db = Firestore.firestore()
                    
                    db.collection("Users").addDocument(data: ["name":fullName as Any,"createdAt": FieldValue.serverTimestamp()]) { err in
                        if let err = err{
                            print("ユーザーの作成に失敗しました")
                            print(err)
                        } else {
                            print("ユーザーを作成しました：\(fullName)")
                          
                        }
                        
                        }
                    db.collection("Users").document(documentId).collection("User").addDocument(data: ["fullName":fullName,"email": email as Any, "profileImage":photoURL, "createdAt": FieldValue.serverTimestamp()]){error in
                        if let error = error{
                            print("エラー")
                            print(error)
                            
                        }else{
                            print("基本情報保存")
                            
                        }
                    }
                    
                    
                    
                    // ...
                }
                //                selfは自分のクラスを指している
                //                Authの中から探そうとする
                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
            }
            
            
            
        }
        
        
        
        
    }
    
    
    
    
}


































































