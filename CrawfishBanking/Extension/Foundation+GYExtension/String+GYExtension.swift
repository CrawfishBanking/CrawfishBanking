//
//  String+GYExtension.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/11.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/11  上午11:21
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

extension String {
    
//     func dateFromServiceTimeStamp(_ TimeStamp:String)->Date? {
//        if  MSRIsNilOrNull(TimeStamp as AnyObject?) || TimeStamp.characters.count<10
//        {
//            return Date()
//        }
//        var tmpStr=TimeStamp as NSString
//        tmpStr=tmpStr.substring(from: 6) as NSString
//        tmpStr=tmpStr.substring(to: tmpStr.length-2) as NSString
//        let tmpTimeStr=TimeInterval(tmpStr.longLongValue/1000)
//        return Date(timeIntervalSince1970: tmpTimeStr)
//    }
    
    func checkifNotNull() -> Bool{
        
        if self.characters.count <= 0 || self.trimmingCharacters(in: NSCharacterSet.whitespaces).characters.count <= 0 {
            return false
        }
        
        return true
    }
    
    func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    func cacheDir() -> String {
        
//        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
    
        let manager = FileManager.default
        let cache = manager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last! as URL
        
        return cache.appendingPathComponent(self).path
        
    }
    
    func delete() {
        
        let manager = FileManager.default
        let cache = manager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last! as URL
    
        try? manager.removeItem(at: cache.appendingPathComponent(self))
        
    }
    
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }
    
}
