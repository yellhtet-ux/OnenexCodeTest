//
//  PromotionResponse.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation
import ObjectMapper

typealias ArticlesData = ArticlesIDNumber

struct PromotionResponse: Mappable {
    var message : String?
    var data : PromotionDataVO?

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}


struct PromotionDataVO : Mappable {
    var twentySeven, twentyEight, twentyNine, thirty, thirtyOne, thirtyTwo, thirtyThree, thirtyFour, thirtyFive, eighteen, nineteen, twenty, twentyOne, twentyTwo, twentyThree, twentyFour, twentyFive, twentySix, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, zero, one, two, three, four, five, six, seven, eight: ArticlesData?

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        twentySeven <- map["27"]
        twentyEight <- map["28"]
        twentyNine <- map["29"]
        thirty <- map["30"]
        thirtyOne <- map["31"]
        thirtyTwo <- map["32"]
        thirtyThree <- map["33"]
        thirtyFour <- map["34"]
        thirtyFive <- map["35"]
        eighteen <- map["18"]
        nineteen <- map["19"]
        twenty <- map["20"]
        twentyOne <- map["21"]
        twentyTwo <- map["22"]
        twentyThree <- map["23"]
        twentyFour <- map["24"]
        twentyFive <- map["25"]
        twentySix <- map["26"]
        nine <- map["9"]
        ten <- map["10"]
        eleven <- map["11"]
        twelve <- map["12"]
        thirteen <- map["13"]
        fourteen <- map["14"]
        fifteen <- map["15"]
        sixteen <- map["16"]
        seventeen <- map["17"]
        zero <- map["0"]
        one <- map["1"]
        two <- map["2"]
        three <- map["3"]
        four <- map["4"]
        five <- map["5"]
        six <- map["6"]
        seven <- map["7"]
        eight <- map["8"]
    }
}


struct ArticlesIDNumber : Mappable {
    var id : Int?
    var article_category_id : Int?
    var title : String?
    var content : String?
    var created_by : Int?
    var updated_by : String?
    var deleted_by : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var image : String? = "home_slide_img"

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        article_category_id <- map["article_category_id"]
        title <- map["title"]
        content <- map["content"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
        deleted_by <- map["deleted_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }
}
