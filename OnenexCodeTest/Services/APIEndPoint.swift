//
//  EndPoint.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import Alamofire
import SwiftyJSON

let baseURLString = "https://codetest.onenex.dev/"

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
