//
//  EndPoint.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import Alamofire
import SwiftyJSON

let baseURLString = ""

protocol EndPoint{
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
}

extension EndPoint {
    var url: String {
        return baseURLString + path
    }
}


struct JSONUtil {
    
    static func parseError(_ err: String) -> String {
        let jsonObj = JSON.init(parseJSON: err)
        var errorMsg = ""
    
        if let msg = jsonObj["message"].string {
            errorMsg = msg
        }
        
        let errObj = jsonObj["errors"]
        errObj.forEach { (key, value) in
            let jValue = errObj[key]
            if let errValue = errObj[key].string {
               errorMsg = errValue
            }else if let arrValue = jValue.array {
                let arrayNames = arrValue.map {$0.stringValue}
                errorMsg = arrayNames.joined(separator: "\n")
            }
        }
        
        return errorMsg
    }
}
