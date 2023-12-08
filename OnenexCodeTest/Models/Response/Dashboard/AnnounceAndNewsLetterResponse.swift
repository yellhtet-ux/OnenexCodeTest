//
//  AnnouncementResponse.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation
import ObjectMapper

typealias ArticlesCategoriesDataObjc = ArticlesCategoriesData

struct AnnounceAndNewsLetterResponse : Mappable{
    var message : String?
    var data : AnnounceAndNewsLetterDataVO?

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}

struct AnnounceAndNewsLetterDataVO : Mappable {
    var four, ten, one, six, zero, eleven, seven, three, five, two, nine, eight : ArticlesCategoriesDataObjc?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        four <- map["4"]
        ten <- map["10"]
        one <- map["1"]
        six <- map["6"]
        zero <- map["0"]
        eleven <- map["11"]
        seven <- map["7"]
        three <- map["3"]
        five <- map["5"]
        two <- map["2"]
        nine <- map["9"]
        eight <- map["8"]
    }
}


struct ArticlesCategoriesData : Mappable {
    var id : Int?
    var name : String?
    var created_by : String?
    var updated_by : String?
    var deleted_by : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var image : String? = "home_slide_img"

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
        deleted_by <- map["deleted_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }
}
