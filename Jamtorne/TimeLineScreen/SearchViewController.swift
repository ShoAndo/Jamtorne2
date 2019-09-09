//
//  SearchViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/27.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import StoreKit

class SearchViewController: UIViewController {
    
    let apiClient = APIClient()
    
    var albums: [Resource]?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        title = "検索"
        tableView.delegate = self
        tableView.dataSource = self
        prepare()
        
        
    }
    func prepare() {
        title = "Search"
        tableView.tableFooterView = UIView()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.dimsBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        SKCloudServiceController.requestAuthorization { status in
            guard status == .authorized else { return }
            print("Authorization status is authorized")
        }
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albums = albums else { return 0 }
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = album.attributes?.name
        cell.detailTextLabel?.text = album.attributes?.artistName
        cell.imageView?.image = nil
        
        if let url = album.attributes?.artwork?.imageURL(width: 100, height: 100) {
            apiClient.image(url: url) { image in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums![indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
        vc.albumID = album.id
        print(album.id)
       self.present(vc, animated: true, completion: nil)
        performSegue(withIdentifier: "AlbumViewController", sender: album.id)
        
    }
    
    
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
            text.count > 0 {
            apiClient.search(term: text) { [unowned self] searchResult in
                DispatchQueue.main.async {
                    self.albums = searchResult?.albums
                    self.tableView.reloadData()
                  
                }
            }
        } else {
            self.albums = nil
            tableView.reloadData()
        }
    }
}
