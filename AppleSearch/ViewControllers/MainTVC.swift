//
//  MainTVC.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController, UISearchBarDelegate {

    @IBOutlet var itemSearchBar: UISearchBar!
    @IBOutlet var itemSegmentController: UISegmentedControl!
    
    var appStoreItems: [AppStoreItem] = []
    var selectedRow: IndexPath?
    var selectedItem: AppStoreItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSearchBar.delegate = self
        
        AppStoreItemController.getItems(type: .song, searchText: "Mac Miller") { (items) in
            self.appStoreItems = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.itemSearchBar.text = ""
            }
        }
      
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = itemSearchBar.text, !searchText.isEmpty else {return}
        let itemType: AppStoreItem.ItemType = (itemSegmentController.selectedSegmentIndex == 0) ? .song : .app
        AppStoreItemController.getItems(type: itemType, searchText: searchText) { (items) in
            self.appStoreItems = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.itemSearchBar.text = ""
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appStoreItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppStoreItemCell", for: indexPath) as! ItemCell
        let appStoreItem = appStoreItems[indexPath.row]
        cell.item = appStoreItem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        if let selectedItem = appStoreItems[indexPath.row]  as? AppStoreItem{
            var title = selectedItem.title
            var subtitle = selectedItem.subtitle
            var imageURL = selectedItem.imageURL
            print("\(title), \(subtitle), \(imageURL)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationvc = segue.destination as? DetailVC
            guard let selectedRow = selectedRow?.row else {return}
            if let selectedItem = appStoreItems[selectedRow] as? AppStoreItem {
                destinationvc?.item = selectedItem
            }
            destinationvc?.selectedIndex = self.itemSegmentController.selectedSegmentIndex
        }
    }



}
