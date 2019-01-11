//
//  AppStoreItemController.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class AppStoreItemController {
    
    static func getItems(type: AppStoreItem.ItemType, searchText: String, completion: @escaping ([AppStoreItem]) -> Void) {
        //build URL
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            print("Our url is not working right")
            completion([])
            return
        }
        //add query items
        let searchTermQuery = URLQueryItem(name: "term", value: searchText)
        let entityQuery = URLQueryItem(name: "entity", value: type.rawValue)
        components.queryItems = [searchTermQuery, entityQuery]
        //Create Datatask
        guard let url = components.url else {
            print("Our query items are having trouble")
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {
                print("No data was recieved")
                completion([])
                return
            }
            guard let topLevelJSON = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any] else {
                print("Could not convert data into JSON")
                completion([])
                return
            }
            guard let appStoreItemDictionaries = topLevelJSON["results"] as? [[String : Any]] else {
                print("Could not get dictionaries from results")
                completion([])
                return
            }
            
            var allItems: [AppStoreItem] = []
            for itemDict in appStoreItemDictionaries {
                if let newItem = AppStoreItem(itemType: type, dict: itemDict) {
                    allItems.append(newItem)
                }
            }
            completion(allItems)
            
        }
        dataTask.resume()
        print(components.url!)
    }
    
    
    static func getImageFor(item: AppStoreItem, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLasString = item.imageURL, let url = URL(string: imageURLasString) else {
            print("item did not have an image that could be made")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Could not get data back from image")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    
}
