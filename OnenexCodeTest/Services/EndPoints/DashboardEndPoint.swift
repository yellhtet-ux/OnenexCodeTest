//
//  DashboardEndPoint.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import Alamofire

enum DashboardEndPoint : EndPoint {

    case promotions
    case announcements
    case newsletters

    var httpMethod: Alamofire.HTTPMethod{
        switch self {
        case  .promotions,.announcements,.newsletters:
            return .get
        }
    }
    
    var path: String{
        switch self{
        case .promotions:
            return Routes.promotions
        case .announcements:
            return Routes.announcements
        case .newsletters:
            return Routes.newsletters
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .promotions,.announcements,.newsletters:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .promotions,.announcements,.newsletters:
          return nil
        }
    }
}
