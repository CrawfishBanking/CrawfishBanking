//
//  NSDate+GYExtension.swift
//  GYHelpToolsSwift
//
//  Created by ZGY on 2016/11/29.
//  Copyright © 2016年 Giant. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/11/29  13:11
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import Foundation

//MARK: - Date

public extension Date {
    
    
    /// 返回日期字符串
    ///
    /// - parameter dateFormat: 日期格式化 默认格式:"yyyy-MM-dd hh:mm:ss"
    ///
    /// - returns: 日期字符串
    func gy_stringFromDate(dateFormat: String?) ->String {
        
        let dateFormatter = DateFormatter()
        
        if dateFormat != nil {
            
            dateFormatter.dateFormat = dateFormat
            
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        }
        
        return dateFormatter.string(from: self)
        
    }
    
    var descDate:String{
        let calendar = NSCalendar.current
        //1.判断是否是今天
        if calendar.isDateInToday(self) {
            //1.0 获取当前时间和系统时间之间的差距(秒数)
            let since = Int(NSDate().timeIntervalSince(self))
            //1.1是否是刚刚
            if since < 60 {
                return "刚刚"
            }
            //1.2多少分钟以前
            if  since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            //1.3多少小时以前
            return "\(since / (60 * 60))小时前"
        }
        
        //else if calendar.isDateInWeekend(self) {
//        
//        let since = Int(NSDate().timeIntervalSince(self))
//        let days = since / (60 * 60 * 24)
//        
//        formatterStr = "\(days) 天前"
//    }
        //2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self) {
            //昨天：HH:mm
            formatterStr = "昨天" + formatterStr
        } else {
           
            //3.处理一年以内
            
            let since = Int(NSDate().timeIntervalSince(self))
            let days = since / (60 * 60 * 24)

//            if days > 30 {
//                formatterStr = " \(Int(days/30)) 个月前"
//            } else {
            formatterStr = " \(days) 天前"
//            }
            
            
            let comps = calendar.dateComponents(Set<Calendar.Component>([.year]), from: self, to: Date())
 
            if comps.year! >= 1 {
                formatterStr = "yyyy-" + formatterStr
            }
        }
        
        //5.按照指定的格式将时间转换为字符串
        //5.1
        let formatter = DateFormatter()
        //5.2设置时间的格式
        formatter.dateFormat = formatterStr
        //5.3设置时间的区域（真机必须设置，否则会转换失败）
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        //5.4格式化
        return formatter.string(from: self)
    }
    
}



