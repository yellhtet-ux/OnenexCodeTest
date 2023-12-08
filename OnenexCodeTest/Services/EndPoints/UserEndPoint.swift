//
//  UserEndPoint.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation
import Alamofire

enum UserEndPoint : EndPoint {
    
    case login(request: LoginRequest)

    var httpMethod: Alamofire.HTTPMethod{
        switch self {
        case  .login:
            return .post
        }
    }
    
    var path: String{
        switch self{
        case .login:
            return Routes.login
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let request):
            return [
                "email": request.email,
                "password": request.password
            ]
        }
    }
}
