//
//  BorderedImageView.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class BorderedImageView: UIImageView {

    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        self.layer.cornerRadius = 3.0
    }

}
