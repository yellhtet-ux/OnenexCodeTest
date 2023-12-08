//
//  DateTimeUtility.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation

class DateTimeUtility : NSObject {
    static let shared = DateTimeUtility()
    
    // To get this "1 May" Date Format
    func getDayAndMonthAsString (_ dateString: String) -> String {
        var resultString = ""
        let dateString = dateString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM"
            
            let resultDateStr = outputFormatter.string(from: date)
            resultString = resultDateStr
        }
        return resultString
    }
}
