//
//  GYConst.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/24.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/24  下午5:58
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit


let Screen_Width = UIScreen.main.bounds.size.width

let Screen_Height = UIScreen.main.bounds.size.height

/// navBar颜色
let navBarColor = UIColor.init(hexColor: "d81d1d")

let tableViewBgC = UIColor.init(hexColor: "efeef3")

let userPhone = "userPhone"

let isBackHome = "CommitisBackHome"


enum EnumIphoneType {
    case Iphone4
    case Ipone5
    case Iphone6
    case Iphone6p
}

enum LoanState {
    
    case QuotaunKown
    case Checking
    case CheckSuccess
    case updated
    
}

struct LoadRequestStruct {
    
    
    var requestState:RequestState!
    var checkState:CheckState!
    var contractState:ContractState!
    var loansState:LoansState!
    var repaymentState:RepaymentState!
    
    init(_ requestState:RequestState,checkState:CheckState,contractState:ContractState,loansState:LoansState,repaymentState:RepaymentState ) {
        
        self.requestState = requestState
        self.checkState = checkState
        self.contractState = contractState
        self.loansState = loansState
        self.repaymentState = repaymentState
        
    }
    
    enum RequestState {
        case unKown
        case checking
        case success
    }
    
    enum CheckState {
        case unKown
        case checking
        case success
    }
    
    enum ContractState {
        case unKown
        case checking
        case success
    }
    
    enum LoansState {
        case unKown
        case checking
        case success
    }
    
    enum RepaymentState {
        case unKown
        case checking
        case success
    }
    
}

var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}


func += <key, value> ( left: inout Dictionary<key, value>, right: Dictionary<key, value>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}



