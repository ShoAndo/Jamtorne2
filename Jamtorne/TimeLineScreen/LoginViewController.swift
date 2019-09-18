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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
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

    



































































