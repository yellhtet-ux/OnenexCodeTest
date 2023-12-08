//
//  PromotionCollectionCell.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import UIKit

class PromotionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var promotionPeriodLbl: UILabel!
    @IBOutlet weak var promotionDateLbl: UILabel!
    @IBOutlet weak var promotionImg: UIImageView!
    
    public var promotionData:  ArticlesData? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        promotionDateLbl.textColor = UIColor(hex: "#5A68F6")
        promotionImg.layer.cornerRadius = 20
    }
    
    private func updateUI () {
        self.promotionDateLbl.text = DateTimeUtility.shared.getDayAndMonthAsString(promotionData?.created_at ?? "_")
        
        self.promotionPeriodLbl.text = promotionData?.title ?? "-"
        
        self.promotionImg.image = UIImage(named: promotionData?.image ?? "")
    }

}
