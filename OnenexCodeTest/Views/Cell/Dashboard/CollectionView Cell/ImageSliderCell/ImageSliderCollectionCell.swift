//
//  ImageSliderCollectionCell.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import UIKit

class ImageSliderCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImg: UIImageView!
    var images : UIImage! {
        didSet {
            self.slideImg.image = images
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
