//
//  RoundedTextView.swift
//  AppleSearch
//
//  Created by Markus Varner on 1/10/19.
//  Copyright © 2019 Markus Varner. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.clipsToBounds = true
    }
}
