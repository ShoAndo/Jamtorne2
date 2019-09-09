//
//  NewPostViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/27.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

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
    
  
    var canMusicCatalogPlayback = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width/2
        profileImage.clipsToBounds = true
        textView.text = ""
//        キーボードを最初から出しておく
        textView.becomeFirstResponder()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    

  

}
