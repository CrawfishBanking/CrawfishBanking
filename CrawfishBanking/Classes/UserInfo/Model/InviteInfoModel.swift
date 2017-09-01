//
//  InviteInfoModel.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/29.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/29  下午3:06
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import ObjectMapper

class InviteInfoModel: NSObject ,Mappable{
    
    var number:Int?
    var ApplyUserName:String = ""
    var ApplyUserPhone:String = ""
    var Product:String = ""
    var Funding:String = ""
    var CreateTime:String = ""
    var CheckState = 0

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        number <- map["number"]
        ApplyUserName <- map["ApplyUserName"]
        ApplyUserPhone <- map["ApplyUserPhone"]
        Product <- map["Product"]
        Funding <- map["Funding"]
        CreateTime <- map["CreateTime"]
        CheckState <- map["CheckState"]
        
    }

}
