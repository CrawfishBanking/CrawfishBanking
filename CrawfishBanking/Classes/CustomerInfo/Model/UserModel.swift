//
//  UserModel.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/15.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/15  下午3:02
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import ObjectMapper

class UserModel: NSObject,Mappable {

    var applicantlevel = ""
    var applicantmobile = ""
    var applicantname = ""
    var areacode = ""
    var companyname = ""
    var createtime = ""
    var financingtype = ""
    var id = ""
    var userid = ""
    var usertype = 0
    var loanAmount = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        applicantlevel <- map["applicantlevel"]
        applicantmobile <- map["applicantmobile"]
        applicantname <- map["applicantname"]
        
        areacode <- map["areacode"]
        companyname <- map["companyname"]
        createtime <- map["createtime"]
        
        financingtype <- map["financingtype"]
        id <- map["id"]
        userid <- map["userid"]
        loanAmount <- map["loanAmount"]
        usertype <- map["usertype"]
    }
    

    
    
}
