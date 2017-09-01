//
//  Tools.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/26.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/26  下午1:07
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit



class Tools {
    
    class func currenIphoneType() -> EnumIphoneType{
        switch Screen_Width {
        case 320:
            return EnumIphoneType.Ipone5
        case 375:
            return EnumIphoneType.Iphone6
        case 414:
            return EnumIphoneType.Iphone6p
        default:
            return EnumIphoneType.Iphone4
        }
    }

    

    class func checkPhoneNumber(_ string: String) -> Bool {
        
        let pattern = "^1[3|4|5|7|8][0-9]\\d{8}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        let res = regex.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0, length: string.characters.count))
        
        if res.count > 0 {
            return true
        }
        
        return false
        
    }
    
    class func checkIdentity(_ string: String) -> Bool {
        
        let pattern = "\\d{14}[[0-9],0-9xX]"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        let res = regex.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0, length: string.characters.count))
        
        if res.count > 0 {
            return true
        }
        
        return false
        
    }
    
    class func checkEmail(_ string: String) -> Bool {
        
        let str = string.replacingOccurrences(of: " ", with: "")
//        let pattern = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
        //[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        let res = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0, length: str.characters.count))
        
        if res.count > 0 {
            return true
        }
        
        return false
        
    }

    class func checkZipCode(_ string: String) -> Bool {
        
//        let pattern = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
//        [A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
        let pattern = "[0-9]\\d{5}(?!\\d)"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        let res = regex.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0, length: string.characters.count))
        
        if res.count > 0 {
            return true
        }
        
        return false
        
    }
    

    class func checkTelphone(_ string: String) -> Bool {
        
        //        let pattern = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
        //[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
        let pattern = "0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        let res = regex.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSRange(location: 0, length: string.characters.count))
        
        if res.count > 0 {
            return true
        }
        
        return false
        
    }
    
    class  func formatNumberToMoney(_ double:Double) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        let str = format.string(from: NSNumber(value: double)) ?? "0.00"
        
        return str
    }

    
    class func creatImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func dateFromServiceTimeStamp(_ TimeStamp:String)->Date? {
        if  MSRIsNilOrNull(TimeStamp as AnyObject?) || TimeStamp.characters.count<10
        {
            return Date()
        }
        var tmpStr=TimeStamp as NSString
        tmpStr=tmpStr.substring(from: 6) as NSString
        tmpStr=tmpStr.substring(to: tmpStr.length-2) as NSString
        let tmpTimeStr=TimeInterval(tmpStr.longLongValue/1000)
        return Date(timeIntervalSince1970: tmpTimeStr)
    }

    
    
}

/**
 判断是不是空或null
 */
func MSRIsNilOrNull(_ object: AnyObject?) -> Bool {
    return object == nil || object is NSNull
    
}




