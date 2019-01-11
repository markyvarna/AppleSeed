//
//  DetailVC.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet var detailImageView: BorderedImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descriptionTextView: RoundedTextView!
    
    var item: AppStoreItem?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item = item, let selectedIndex = selectedIndex else {return}
        titleLabel.text = item.title
        if selectedIndex == 0 {
            subtitleLabel.text = item.subtitle
            descriptionTextView.isHidden = true
        } else if selectedIndex == 1 {
            subtitleLabel.text = ""
            descriptionTextView.text = item.subtitle
            descriptionTextView.isHidden = false
        } else {
            subtitleLabel.text = ""
            titleLabel.text = ""
            descriptionTextView.isHidden = true
        }
        
        AppStoreItemController.getImageFor(item: item) { (image) in
            DispatchQueue.main.async {
                self.detailImageView.image = image
            }
        }
       
    }

}
