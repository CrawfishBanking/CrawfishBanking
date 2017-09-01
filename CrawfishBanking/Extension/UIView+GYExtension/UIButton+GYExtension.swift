////
////  UIButton+GYExtension.swift
////  RunTime_UIButton重复点吉
////
////  Created by zhuguangyang on 2016/11/28.
////  Copyright © 2016年 Giant. All rights reserved.
////
////  Github:https://github.com/airfight
////  简书:http://www.jianshu.com/users/17d6a01e3361
//
import UIKit
//
extension UIButton {
    
    public convenience init(_ frame: CGRect,imageName:String?,title: String?,target:AnyObject?,action:Selector) {
        
        self.init(frame: frame)
        if imageName != nil {
            self.setImage(UIImage(named: imageName!), for: UIControlState.normal)
        }
        self.setTitle(title, for: UIControlState.normal)
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        self.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
}
//
//public extension UIButton {
//    
//    private struct gy_associatedKeys{
//        
//        static var acceptEventInterval = "gy_acceptEventInterval"
//        static var acceptEventTime = "gy_acceptEventTime"
//        
//    }
//    
//    //重复点击的间隔
//    var gy_acceptEventInterval: TimeInterval {
//        
//        get{
//            // objc_getAssociatedObject 返回一个给定的键相关联的值  的对象
//            if let acceptEventInterval:TimeInterval = objc_getAssociatedObject(self, &gy_associatedKeys.acceptEventInterval) as? TimeInterval {
//                return acceptEventInterval
//            }
//            return 1.2
//        }
//        set {
//            objc_setAssociatedObject(self, &gy_associatedKeys.acceptEventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//    }
//    //OBJC_ASSOCIATION_ASSIGN 若引用相关联的对象
//    //OBJC_ASSOCIATION_COPY 相关联对象的复制 自动
//    //OBJC_ASSOCIATION_COPY_NONATOMIC 不自动
//    //OBJC_ASSOCIATION_RETAIN 指定强引用的相关的对象,自动
//    //OBJC_ASSOCIATION_RETAIN_NONATOMIC 不自动
//    
//    var gy_acceptEventTime:TimeInterval {
//        get{
//            if let acceptTime = objc_getAssociatedObject(self, &gy_associatedKeys.acceptEventTime) as? TimeInterval {
//                return acceptTime
//            }
//            
//            return 1.2
//        }
//        
//        set {
//            objc_setAssociatedObject(self, &gy_associatedKeys.acceptEventTime, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    
//    override open class func initialize() {
//        
//        let before: Method = class_getInstanceMethod(self, #selector(UIButton.sendAction(_:to:for:)))
//        let after: Method = class_getInstanceMethod(self, #selector(UIButton.gy_sendAction(_:to:for:)))
//        method_exchangeImplementations(before, after)
//        
//    }
//    
//    func gy_sendAction(_ action:Selector, to target:AnyObject?,for event: UIEvent? )
//    {
//        
//        if NSDate().timeIntervalSince1970 - self.gy_acceptEventTime < self.gy_acceptEventInterval {
//            return;
//        }
//        
//        if self.gy_acceptEventInterval > 0 {
//            self.gy_acceptEventTime = NSDate().timeIntervalSince1970
//        }
//        
//        self.gy_sendAction(action, to: target, for: event)
//        
//    }
//    
//}
