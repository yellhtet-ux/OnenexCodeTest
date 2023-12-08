//
//  LoginResponse.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation
import ObjectMapper

struct LoginResponse : Mappable {
    var message : String?
    var data : LoginDataVO?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}


struct LoginDataVO : Mappable {
    var access_token : String?
    var user : UserInfoData?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        access_token <- map["access_token"]
        user <- map["user"]
    }
}

struct UserInfoData : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var email_verified_at : String?
    var date_of_birth : String?
    var gender : String?
    var id_type : String?
    var id_number : String?
    var status : String?
    var created_by : String?
    var updated_by : String?
    var deleted_by : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var allowed_permissions : [Allowed_permissions]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        email_verified_at <- map["email_verified_at"]
        date_of_birth <- map["date_of_birth"]
        gender <- map["gender"]
        id_type <- map["id_type"]
        id_number <- map["id_number"]
        status <- map["status"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
        deleted_by <- map["deleted_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        allowed_permissions <- map["allowed_permissions"]
    }
}

struct Allowed_permissions : Mappable {
    var name : String?
    var action : String?
    var resource : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        name <- map["name"]
        action <- map["action"]
        resource <- map["resource"]
    }

}
