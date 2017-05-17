//
//  UserModel.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 16..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import ObjectMapper
struct User: Mappable {
    
    var id: Int!
    var name : String?
    var email : String?
    var lastConnectDate : Date?
    var likeCount : Int?
    var reviewCount : Int?
    var userPoint : Int?
    var userLevel : Int?
    var goodValue : Int?
    var sosoValue : Int?
    var badValue : String?
    
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.email <- map["email"]
        self.likeCount <- map["like_count"]
        self.reviewCount <- map["review_count"]
        self.userLevel <- map["img"]
        self.userPoint <- map["status"]
        self.goodValue <- map["good_rate"]
        self.sosoValue <- map["soso_rate"]
        self.badValue <- map["bad_rate"]
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.lastConnectDate <- (map["input_date"], DateFormatterTransform(dateFormatter: format))
    }
    
    
}
