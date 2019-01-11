//
//  AppStoreItem.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import Foundation

struct AppStoreItem {
    
    let title: String
    let subtitle: String
    let imageURL: String?
    
    enum ItemType: String {
        case app = "software"
        case song = "musicTrack"
    }
    
}

extension AppStoreItem {
    //Failable Initializer
    init?(itemType: AppStoreItem.ItemType, dict: [String : Any]) {
        if itemType == .app {
            //build an app AppStoreItem
            guard let title = dict["trackName"] as? String, let subtitle = dict["description"] as? String else {return nil}
            let imageURL = dict["artworkUrl100"] as? String
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
        } else if itemType == .song {
            //build an song AppStoreItem
            guard let title = dict["artistName"] as? String, let subtitle = dict["trackName"] as? String else {return nil}
            let imageURL = dict["artworkUrl100"] as? String
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
        } else {
            print("Forgot to add availability for other types of items")
            return nil
        }
    }
    
}
