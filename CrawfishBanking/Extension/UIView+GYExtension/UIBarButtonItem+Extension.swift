//
//  UIBarButtonItem+Extension.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午2:09
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

extension UIBarButtonItem{
    
    /**
     导航栏按钮
     
     - parameter imageName: 图片名称，可为nil
     - parameter target:    响应者
     - parameter action:    事件
     
     - returns:UIBarButtonItem
     */
    class func  createBarButtonItem(_ imageName:String?,title: String?,target:AnyObject?,action:Selector) -> UIBarButtonItem{
        
        let btn = UIButton()
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: UIControlState())
        }
        
        if title != nil {
            btn.setTitle(title, for: UIControlState.normal)
        }
        
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
        
    }
    
}
