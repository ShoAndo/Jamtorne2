//
//  NewPostViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/27.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import StoreKit

class NewPostViewController: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    let apiClient = APIClient()
    var trackID: String!
    var track: Resource?
    var canMusicCatalogPlayback = false
    var musicName:String?
    var performerName: String?
    var year: String?
    var songImage: String?
    var postDocumentId = ""
    let cloudServiceController = SKCloudServiceController()
    var post:[Post] = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width/2
        profileImage.clipsToBounds = true
        textView.text = ""
        
      
        
        let user = Auth.auth().currentUser
        
//        db.collection("User").getDocuments { (QuerySnapshot, error) in
//            if error == nil, let snapshot = QuerySnapshot{
//                for document in snapshot.documents{
//                    let data = document.data()
//                    let user = User(documentID: user!.uid, fullName: data["fullName"] as! String, email: data["email"] as! String, profileImage: data["profiliImage"] as! String)
//                    self.user = user
//                }
//            }
//
//        }
 
 
 
        //        変数だから小文字にしておく
//        db.collection("Post").addSnapshotListener { (querySnapshot, error) in
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
//            var results: [Post] = []
//            for document in documents {
//                let artistName = document.get("artistName") as! String
//                let createdAt = document.get("createdAt") as! String
//                let interesId = document.get("interestId") as! String
//                let musicImage = document.get("musicImage") as! String
//                let numberOfLikes = document.get("numberOfLikes") as! Int
//                let postText = document.get("postText") as! String
//                let songName = document.get("songName") as! String
//                let uid = document.get("uid") as! String
//                let userDidLike = document.get("userDidLike") as! Bool
//                let documentId = document.documentID
//                self.postDocumentId = documentId
//
//                let post = Post(documentId: documentId, author: self.user, uid: uid, createdAt: createdAt, musicImage: musicImage, artistName: artistName, songName: songName, postText: postText, numberOfLikes: numberOfLikes, interestId: interesId, userDidLike: userDidLike)
//                results.append(post)
//
//            }
//            //           変数roomを書き換える
//            self.post = results
//        }
//        キーボードを最初から出しておく
        textView.becomeFirstResponder()
      
//         prepare()
        if let user = user {
            
            let fullName = user.displayName!
            
            let photoURL = user.photoURL!
            
            var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
            do{
                let photoData = try Data(contentsOf: photoURL)
                photoImage = UIImage(data: photoData)!
            }catch{
                print(error.localizedDescription)
            }
            profileImage.image! = photoImage
            self.fullName.text! = fullName
        }
        songName.text! = musicName!
        artistName.text! = performerName!
        yearLabel.text! = year!
        print(musicName as Any)
        print(performerName as Any)
        print(year as Any)
        print(songImage as Any)
        let musicImageUrl = URL(string: songImage!)!
        var songImage:UIImage!
        do{
            let musicImageData = try Data(contentsOf: musicImageUrl)
            songImage = UIImage(data: musicImageData)!
            musicImage.image! = songImage
        }catch{
            
            print(error.localizedDescription)
        }
        
    }
    func prepare() {
        guard trackID == nil else{
            apiClient.album(id: trackID!) { [unowned self] track in
                DispatchQueue.main.async {
                    self.track = track
                    
                }
            }
            return
        }
        self.cloudServiceController.requestCapabilities { capabilities, error in
            guard capabilities.contains(.musicCatalogPlayback) else { return }
            self.canMusicCatalogPlayback = true
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
       prepare()
        super.viewWillAppear(animated)
        self.configureObserver()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
//        self.removeObserver() // Notificationを画面が消えるときに削除
    }
    
    // Notificationを設定
    func configureObserver() {
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Notificationを削除
/*    func removeObserver() {
        
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
 */
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // キーボードが現れた時に、画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {
//        ユーザの情報
        let userInfo = notification?.userInfo ?? [:]
        
        let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize!.height + 10, right: 0)
        self.textView.scrollIndicatorInsets = self.textView.contentInset
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        self.textView.contentInset = UIEdgeInsets.zero
        self.textView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        
     
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // Returnキーを押したときにキーボードを下げる
        return true
    }
    func createNewPost(){
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            let profileName = user.displayName!
            let uid = user.uid
            
            let photoURL = URL(string: songImage!)
            var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
            do{
                let photoData = try Data(contentsOf: photoURL!)
                photoImage = UIImage(data: photoData)!
                
            }catch{
                print(error.localizedDescription)
            }
            
            profileImage.image! = photoImage
            self.fullName.text! = profileName
            let artistName = performerName
            let songName = musicName
            let postText = textView.text
            let numberOfLikes = 0
            let interestedId = "i1"
        
            db.collection("Post").addDocument(data: ["uid": uid, "musicImage":photoURL!.absoluteString,"artistName":artistName as Any,"songName":songName as Any,"postText":postText as Any,"numberOfLikes":numberOfLikes,"interestId":interestedId,"userDidLike":true,"createdAt": Timestamp()]){ err in
            if let err = err{
                print("投稿に失敗しました")
                print(err)
            } else {
                print("投稿しました")
//                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
                DispatchQueue.main.async {
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "maintab") as! UITabBarController
                    self.present(secondViewController, animated: true, completion: nil)
                }
                
            }
            }
        }
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toTimeLine"{
//            let vc = segue.destination as! ViewController
//            vc.postDocumentId = sender as! String
//        }
//    }
    
    @IBAction func didClickBackButton(_ sender: Any) {
    }
    
    @IBAction func didClickPostButoon(_ sender: Any) {
        if textView == nil{
            
        }else {
            createNewPost()
            textView.resignFirstResponder()
//            dismiss(animated: true, completion: nil)
            
        }
    }
    
  

}
