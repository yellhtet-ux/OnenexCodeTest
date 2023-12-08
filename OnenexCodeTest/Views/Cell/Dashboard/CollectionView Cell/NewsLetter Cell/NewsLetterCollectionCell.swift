//
//  NewsLetterCollectionCell.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import UIKit

class NewsLetterCollectionCell: UICollectionViewCell {

    @IBOutlet var newsLetterEditionLbl: UILabel!
    @IBOutlet var newsLetterDateLbl: UILabel!
    @IBOutlet var newsLetterImg: UIImageView!
    
    public var newsLetterData: ArticlesCategoriesDataObjc? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsLetterDateLbl.textColor = UIColor(hex: "#5A68F6")
    }
    
    private func updateUI () {
        self.newsLetterDateLbl.text = DateTimeUtility.shared.getDayAndMonthAsString(newsLetterData?.created_at ?? "_")
        
        self.newsLetterEditionLbl.text = newsLetterData?.name ?? "-"
        
        self.newsLetterImg.image =  UIImage(named: newsLetterData?.image ?? "")
    }
}
