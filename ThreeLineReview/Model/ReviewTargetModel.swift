//
//  ReviewTargetModel.swift
//  
//
//  Created by LEOFALCON on 2017. 5. 13..
//
//

import ObjectMapper
struct ReviewTarget: Mappable {
    
    var id: Int!
    var categoryId: String?
    var name : String?
    var score : Double?
    var basicInfo : String?
    var inputDate : Date?
    var likeCount : Int?
    var reviewCount : Int?
    var createUserId : Int?
    var goodValue : Int?
    var sosoValue : Int?
    var badValue : Int?
    var imageID : String?
    var status : Int?
    
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.categoryId <- map["category_id"]
        self.createUserId <- map["create_user_id"]
        self.name <- map["name"]
        self.score <- map["score"]
        self.basicInfo <- map["basic_info"]
        self.likeCount <- map["lick_count"]
        self.reviewCount <- map["review_count"]
        self.createUserId <- map["create_user_id"]
        self.goodValue <- map["good_value"]
        self.sosoValue <- map["soso_value"]
        self.badValue <- map["bad_value"]
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.inputDate <- (map["input_date"], DateFormatterTransform(dateFormatter: format))
        self.imageID <- map["img"]
        self.status <- map["status"]
    }

    
}
