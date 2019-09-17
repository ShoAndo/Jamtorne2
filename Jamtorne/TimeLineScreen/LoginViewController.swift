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

//   var documentID = ""
  
//    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
//        let db = Firestore.firestore()
//
//        //        変数だから小文字にしておく
//        db.collection("User").addSnapshotListener { (querySnapshot, error) in
//            //            querySnapshotの中にはroomに中の全データが入っている
//            guard let documents = querySnapshot?.documents else{
//                //                roomの中に何もない場合、処理を中断
//                return
//            }
//            //            登録をしているから一回登録するだけでオッケー
//            //            全件のデータをroomの中に入れ直している
//            //            扱いやすくするため
//            //            変数documentsにroomの全データがあるので
//            //            それを元に配列を作成し、画面を更新する
//            //            documentはnameやcreatedが入っている
//            //            .get()で値取得  any が入る　キャストする realmでも？
//            //            Roomを新しく作っている
//            //            documentIDはよくわからん文字列のやつ
//            var results: [User] = []
//            for document in documents {
//                let fullName = document.get("fullName") as! String
//                let email = document.get("email") as! String
//                let profileImage = document.get("profileImage")as! String
//                self.documentID = document.documentID
//                UserDefaults.standard.set(self.documentID, forKey: "documentId")
////                let vc = self.storyboard?.instantiateViewController(withIdentifier: "toNewPost") as! NewPostViewController
////                vc.documentId = documentID
////                let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
////                VC.documentId = documentID
//                let user = User(documentID: self.documentID, fullName: fullName, email: email, profileImage: profileImage)
//
//                results.append(user)
//
//            }
//            //           変数roomを書き換える
//            self.users = results
//        }
     
   
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    
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
                    let fullName = user.displayName!
                    let email = user.email!
                    let photoURL = user.photoURL!
                    let db = Firestore.firestore()
                    db.collection("User").document(user.uid).setData([
                        "fullName":fullName,
                        "email": email,
                        "profileImage":photoURL.absoluteString,
                        "createdAt": FieldValue.serverTimestamp(),
                        "uid": user.uid
                    ]) { err in
                        if let err = err{
                            print("ユーザーの作成に失敗しました")
                            print(err)
                        } else {
                            print("ユーザーを作成しました：\(fullName)")
                        }
                    }
                }
               
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
            }
        }
    }
}

    



































































