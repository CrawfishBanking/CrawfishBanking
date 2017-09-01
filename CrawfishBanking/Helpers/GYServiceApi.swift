//
//  ServiceApi.swift
//  GYHelpToolsSwift
//
//  Created by ZGY on 2017/4/14.
//  Copyright © 2017年 Giant. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/14  17:20
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit


/// APIDemo
class GYServiceApi: NSObject {
    
    #if DEBUG
//    static var host: String = "http://192.168.173.22:2017"
    static var host: String = "http://appbanking.51xlx.com:8660"
    #else
    static var host: String = "http://appbanking.51xlx.com:8660"
    #endif
    
    internal class func getPhoneCode() -> String {
        
        return "\(host)/App/AppLogin/GetPhoneCode"
    }

    internal class func login() -> String {
        return "\(host)/App/AppLogin/APPLogin"
    }
    

    internal class func register() -> String {
        return "\(host)/APP/AppLogin/APPLogin"
    }
    

    internal class func submitUserInfoDetaile() -> String {
        return "\(host)/App/AppLogin/SubmitUserInfoDetaile"
    }

    internal class func SubmitApplication() -> String {
        return "\(host)/App/Apply/SubmitApply"
    }
    
    
    internal class func GetUserInfo() -> String {
        
        return "\(host)/App/User/GetUserInfo"
    }

    internal class func GetUserApplyState() -> String {
        
        return "\(host)/App/User/GetUserApplyState"
    }
    

    internal class func GetUserApplyStateByID() -> String {
        
        return "\(host)/App/User/GetUserApplyStateByID"
    }
   
    internal class func CompactInfo() -> String {
        
        return "\(host)/App/User/AppCompactInfo"
    }

    internal class func GetMyInviter() -> String {
        
        return "\(host)/App/User/GetMyInviter"
    }
    //GetPost/App/User/GetInviterInfo
    

    internal class func GetInviterInfo() -> String {
        
        return "\(host)/App/User/GetInviterInfo"
    }
    

    internal class func GetUserApplyHistory() -> String {
        
        return "\(host)/App/Apply/GetUserApplyHistory"
    }
    

    internal class func IsCanApply() -> String {
        
        return "\(host)/App/Apply/IsCanApply"
    }

    
}
