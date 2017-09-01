//
//  RequestStateModel.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/13.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/13  下午1:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift
import Realm


class RequestStateModel: Object {
    
    dynamic var requestStateID = ""
    dynamic var personInfo = "0"
    dynamic var shopType = "0"
    dynamic var sellerInfo = "0"
    dynamic var friendInfo = "0"
    
    override class func primaryKey() -> String? {
        return "requestStateID"
    }

}
