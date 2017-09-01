//
//  BankTypeInfoRealm.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/14.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/14  下午1:20
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift

class BankTypeInfoRealm: Object {
    
    dynamic var bankTypeInfoRealmID = ""
    
//    dynamic var dic = ["":""]
    dynamic var isRequest = false
    
//    dynamic var userModel = UserModel(map: <#Map#>)
    
    
    // 融资种类
    /// </summary>
    dynamic var  financingtype = ""
    /// <summary>
    /// 公司名称
    /// </summary>
    dynamic var  companyname = ""
    /// <summary>
    /// 申请人姓名（公司法人）
    /// </summary>
    dynamic var  applicantname = ""
    /// <summary>
    /// 申请人电话
    /// </summary>
    dynamic var  applicantmobile = ""
    /// <summary>
    /// 申请融资等级（加盟）
    /// </summary>
    dynamic var  applicantlevel = ""
    /// <summary>
    /// 区域代码（已加盟代理商根据区域代码确定融资金额）
    /// </summary>
    dynamic var  areacode = ""
    
    dynamic var  moneyLimit = ""
    dynamic var  usertype = ""

    
    override class func primaryKey() -> String? {
        return "bankTypeInfoRealmID"
    }

}
