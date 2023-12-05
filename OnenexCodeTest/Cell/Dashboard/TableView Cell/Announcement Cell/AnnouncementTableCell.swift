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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    
}
