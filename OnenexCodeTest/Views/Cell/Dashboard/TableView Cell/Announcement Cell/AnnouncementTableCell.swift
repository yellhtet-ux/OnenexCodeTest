//
//  AnnouncementTableCell.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import UIKit

class AnnouncementTableCell: UITableViewCell {

    @IBOutlet var announceDayLbl: UILabel!
    @IBOutlet var announceDateLbl: UILabel!
    
    public var announceData: ArticlesCategoriesDataObjc? {
        didSet {
            updateUI ()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        announceDateLbl.textColor = UIColor(hex: "#5A68F6")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    private func updateUI () {
        self.announceDateLbl.text = DateTimeUtility.shared.getDayAndMonthAsString(announceData?.created_at ?? "_")
        
        self.announceDayLbl.text = announceData?.name ?? "-"
    }
    
}
