//
//  UIViewExtenion.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import Foundation
import UIKit

class CircularView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI () {
        layer.cornerRadius = bounds.height / 2
        self.clipsToBounds   = true
    }
}
