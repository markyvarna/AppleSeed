//
//  ItemCell.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    
    var item: AppStoreItem? {
        didSet {
            guard let item = item else {return}
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
            itemImageView.image = nil
            AppStoreItemController.getImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.itemImageView.image = image
                    }
                } else {
                    print("Image was nil")
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
