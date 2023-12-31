//
//  APIClient.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper

class APIClient: NSObject {
    
    static let shared = APIClient()
    
    func requestGETURL(_ strURL: String,_ params: [String : AnyObject]?,headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        print("GET API Link : \(strURL)")
        print("GET Parameter : \(params)")
        print("GET Header : \(headers)")
        AF.request(strURL, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { response in
                print("GET API Response : \(response.result)")
                switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
                }
            }
    }
    
    func requestPOSTURL(_ strURL : String, params: [String : AnyObject]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        print("POST API Link : \(strURL)")
        print("POST Parameter : \(params)")
        print("POST Header : \(headers)")
        AF.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 600)
            .responseJSON { (response) -> Void in
                print("POST API Link : \(strURL)")
                print("POST API Header : \(response.response?.allHeaderFields)")
                
            switch response.result {
                case .success:
                    if let json = response.data {
                        success(json)
                    }
                case let .failure(error):
                    failure(error)
            }
        }
    }
}
