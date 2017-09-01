//
//  UserAccount.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/11.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/11  上午10:47
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class UserAccount: NSObject ,NSCoding{
    
    
    var phone: String?
    var acctoken: String?
    var data: String?
    var status: String?
    
    static let accountPath = "account.plist".cacheDir()
    
    static var account: UserAccount?
    
    override init() {
        super.init()
    }
    
    func saveAccount() {
       
        NSKeyedArchiver.archiveRootObject(self, toFile:UserAccount.accountPath)
        
    }

    class func userLogin() -> Bool{
        
        return loadAccount() != nil
        
    }
    
    class func deleateAccount() {
        
        account = nil
        "account.plist".delete()
        
    }
    
    class func loadAccount() -> UserAccount? {
        
        if account != nil{
            return account
        }
        
        account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.accountPath) as? UserAccount
        
        return account
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(acctoken, forKey: "acctoken")
        aCoder.encode(data, forKey: "data")
        aCoder.encode(status, forKey: "status")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        phone = aDecoder.decodeObject(forKey: "phone") as?
        String
        acctoken = aDecoder.decodeObject(forKey: "acctoken") as? String
        data = aDecoder.decodeObject(forKey: "data") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
    }

}
