//
//  Router.swift
//  GYHelpToolsSwift
//
//  Created by ZGY on 2017/4/14.
//  Copyright © 2017年 Giant. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/14  17:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import  Alamofire


enum GYRouter: URLRequestConvertible {
    
    
    public func asURLRequest() throws -> URLRequest {
        return self.urlRequest
    }

    static var token:String?
    
    case login(parameters:[String: String])
    case register(parameters:[String: String])
    case getPhoneCode(parameters:[String: String])
    case submitUserInfoDetaile(parameters:[String: String])
    case submitApplication(parameters:[String: String])
    case getUserInfo(parameters:[String: String])
    case getUserApplyState(parameters:[String: String])
    case compactInfo(parameters:[String:String])
    case getMyInviter(parameters:[String:String])
    case getInviterInfo(parameters:[String:String])
    case getUserApplyHistory(parameters:[String:String])
    case getUserApplyStateByID(parameters:[String:String])
    case isCanApply(parameters:[String:String])
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
            
        case .login:
            return .post
        case .register:
            return .post
        case .getPhoneCode:
            return .get
        case .submitUserInfoDetaile:
            return .post
        case .submitApplication:
            return .post
        case .getUserInfo:
            return .post
        case .getUserApplyState:
            return .post
        case .compactInfo,.isCanApply,.getMyInviter,.getInviterInfo,.getUserApplyHistory,.getUserApplyStateByID:
            return .post
        
        }
        
    }
    
    
    var path: String {
        
        switch self {
        case .login:
            return GYServiceApi.login()
        case .register:
            return GYServiceApi.register()
        case .getPhoneCode:
            return GYServiceApi.getPhoneCode()
        case .submitUserInfoDetaile:
            return GYServiceApi.submitUserInfoDetaile()
        case .submitApplication:
            return GYServiceApi.SubmitApplication()
        case .getUserInfo:
            return GYServiceApi.GetUserInfo()
        case .getUserApplyState:
            return GYServiceApi.GetUserApplyState()
        case .compactInfo:
            return GYServiceApi.CompactInfo()
        case .getMyInviter:
            return GYServiceApi.GetMyInviter()
        case .getInviterInfo:
            return GYServiceApi.GetInviterInfo()
        case .getUserApplyHistory:
            return GYServiceApi.GetUserApplyHistory()
        case .getUserApplyStateByID:
            return GYServiceApi.GetUserApplyStateByID()
        case .isCanApply:
            return GYServiceApi.IsCanApply()
        }
        
    }
    
    var urlRequest: URLRequest {
        
        let url = URL(string: path)!
        
        var mutableURLRequest = URLRequest(url: url)
        mutableURLRequest.httpMethod = method.rawValue
        
        if let token = GYRouter.token {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "usertoken")
        }
        
        mutableURLRequest.setValue("com.ozner", forHTTPHeaderField: "clientid")
        mutableURLRequest.setValue("1.0", forHTTPHeaderField: "appversion")

        switch self {
            
        case .login(var parm),.register(var parm),.getPhoneCode(parameters: var parm),.submitUserInfoDetaile(parameters: var parm),.submitApplication(parameters: var parm),.getUserInfo(parameters: var parm),.getUserApplyState(parameters: var parm),.compactInfo(parameters: var parm),.getMyInviter(var parm),.getInviterInfo(parameters: var parm),.getUserApplyHistory(parameters: var parm),.getUserApplyStateByID(parameters: var parm),.isCanApply(parameters: var parm):
            do {
                
                if UserAccount.loadAccount()?.acctoken != nil {
                    parm["usertoken"] = UserAccount.loadAccount()?.acctoken
                    
                }
                
                return try Alamofire.URLEncoding().encode(mutableURLRequest, with: parm)
            } catch  {
                
            }

        }
        
        return mutableURLRequest
        
    }
    
}
