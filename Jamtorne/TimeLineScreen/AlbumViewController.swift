//
//  AlbumViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import StoreKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let apiClient = APIClient()
    let cloudServiceController = SKCloudServiceController()
    
    var albumID: String!
    var album: Resource?
    
    var canMusicCatalogPlayback = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
       prepare()
    }
    func prepare() {
        guard albumID == nil else{
            apiClient.album(id: albumID!) { [unowned self] album in
                DispatchQueue.main.async {
                    self.album = album
                    self.tableView.reloadData()
                }
            }
            return
        }
            
        self.cloudServiceController.requestCapabilities { capabilities, error in
            guard capabilities.contains(.musicCatalogPlayback) else { return }
            self.canMusicCatalogPlayback = true
        }
    }
}

extension AlbumViewController:UITableViewDataSource,UITableViewDelegate{
     func numberOfSections(in tableView: UITableView) -> Int {
        guard album != nil else { return 0 }
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let album = album else { return 0 }
        if section == 0 {
            return 1
        } else {
            return album.relationships!.tracks!.count
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumHeaderCell", for: indexPath) as! AlbumHeaderCell
            cell.songName.text = album!.attributes?.name
            cell.artistName.text = album!.attributes?.artistName
            cell.yearlabel.text = album!.attributes?.releaseDate
            if let url = album!.attributes?.artwork?.imageURL(width: 220, height: 220) {
                apiClient.image(url: url) { image in
                    cell.musicImage.image = image
                }
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = album?.relationships!.tracks![indexPath.row]
        cell.textLabel?.text = track?.attributes?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else {
            return 40
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //      tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }
        performSegue(withIdentifier: "toNewPost", sender: self)
        
    }
}

class AlbumHeaderCell:UITableViewCell{
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var yearlabel: UILabel!
    
    
}



