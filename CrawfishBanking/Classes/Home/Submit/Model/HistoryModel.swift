//
//  HistoryModel.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/7/4.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/7/4  下午4:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import ObjectMapper

class HistoryModel: NSObject ,Mappable{
    
    var ApplyTime = ""
    var CheckState_1 = 0
    var CheckState_2 = 0
    var Funding = ""
    var Product = ""
    var UpdateTime = ""
    var flowmsg = ""
    var signState = 0
    
    var ID = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
     
        ApplyTime <- map["ApplyTime"]
        CheckState_1 <- map["CheckState_1"]
        CheckState_2 <- map["CheckState_2"]
        Funding <- map["Funding"]
        Product <- map["Product"]
        UpdateTime <- map["UpdateTime"]
        flowmsg <- map["flowmsg"]
        signState <- map["signState"]
        ID <- map["ID"]
        
    }
    
}
