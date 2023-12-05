//
//  CardView.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/5/23.
//

import Foundation
import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.3
//    override func awakeFromNib() {
//        super.awakeFromNib()
//           setupUI()
//       }
       
//       override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//           setupUI()
//       }
       

        override func layoutSubviews() {
            super.layoutSubviews()
            setupUI()
        }
    
        private func setupUI() {
            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            layer.masksToBounds = false
        }
    
}
