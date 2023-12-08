//
//  APIManager.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

enum APIError: Error {
    case parsingError
}

class APIManager {
    
    static let shared = APIManager()
    let mApiClient = APIClient.shared
    
    func getData<T: Mappable> (_ endPoint: EndPoint) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            self.mApiClient.requestGETURL(endPoint.url, endPoint.parameters as? [String : AnyObject] ?? [:], headers: endPoint.headers, success: { (response) in
                let responseJSON = JSON(response)
                if let resp: T = Mapper<T>().map(JSONString: responseJSON.rawString()!) {
                    observer.onNext(resp)
                }else {
                    observer.onError(APIError.parsingError)
                }
            }) { (error) in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func postData<T: Mappable> (_ endPoint: EndPoint) -> Observable<T> {
            return Observable<T>.create { observer -> Disposable in
                self.mApiClient.requestPOSTURL(endPoint.url, params: endPoint.parameters as? [String : AnyObject] ?? [:], headers: endPoint.headers, success: { (response) in
                    let responseJSON = JSON(response)
                    if let resp: T = Mapper<T>().map(JSONString: responseJSON.rawString()!) {
                        observer.onNext(resp)
                    }else {
                        observer.onError(APIError.parsingError)
                    }
                }) { (error) in
                    observer.onError(error)
                }
                return Disposables.create()
            }
    }
}
