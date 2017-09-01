//
//  FillCResultModel.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/27.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/27  上午9:56
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import ObjectMapper
class FillCResultModel: NSObject, Mappable {
    
    var data: Int?
    var msg: String = ""
    var status: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
    
        data <- map["data"]
        msg <- map["msg"]
        status <- map["status"]
    }

}
