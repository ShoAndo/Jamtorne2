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
    var documentId = ""
    var musicName:String?
    var performerName: String?
    var year: String?
    var songImage: String?
     let cloudServiceController = SKCloudServiceController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width/2
        profileImage.clipsToBounds = true
        textView.text = ""
//        キーボードを最初から出しておく
        textView.becomeFirstResponder()
//         prepare()
        let user = Auth.auth().currentUser
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
        print(documentId)
        let musicImageUrl = URL(string: songImage!)!
        var songImage:UIImage!
        do{
            let musicImageData = try Data(contentsOf: musicImageUrl)
            songImage = UIImage(data: musicImageData)!
            print(songImage)
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
            let photoURL = user.photoURL!
            
            var photoImage: UIImage = UIImage(named: "defaultProfileImage")!
            do{
                let photoData = try Data(contentsOf: photoURL)
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
        
            db.collection("User").document(documentId).collection("Post").addDocument(data: ["uid": uid, "musicImage":photoImage,"artistName":artistName as Any,"songName":songName as Any,"postText":postText as Any,"numberOfLikes":numberOfLikes,"interestId":interestedId,"userDidLike":true,"createdAt": FieldValue.serverTimestamp()]){ err in
            if let err = err{
                print("投稿に失敗しました")
                print(err)
            } else {
                print("投稿しました")
            }
            }
        }
        
    }
    
    @IBAction func didClickBackButton(_ sender: Any) {
    }
    
    @IBAction func didClickPostButoon(_ sender: Any) {
        if textView == nil{
            
        }else {
            createNewPost()
            textView.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            
        }
    }
    
  

}
