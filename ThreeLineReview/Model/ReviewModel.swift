//
//  ReviewModel.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import ObjectMapper
struct Review : Mappable {
    
    var id: Int!
    var writer: String?
    var targetId : String?
    var score : Double?
    var content : String?
    var inputDate : Date?
    
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.writer <- map["writer"]
        self.targetId <- map["target_id"]
        self.content <- map["content"]
        self.score <- map["score"]
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.inputDate <- (map["input_date"], DateFormatterTransform(dateFormatter: format))
    }
    
    
}
