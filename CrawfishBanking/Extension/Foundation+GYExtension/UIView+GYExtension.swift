//
//  UIView+GYExtension.swift
//  GYHelpToolsSwift
//
//  Created by zhuguangyang on 2016/11/23.
//  Copyright © 2016年 Giant. All rights reserved.
//
//  Github:https://github.com/airfight
//  简书:http://www.jianshu.com/users/17d6a01e3361

import UIKit

//MARK: - Frame
public extension UIView {
    
    
    /// x == 左
    var x : CGFloat {
        get{
            return self.frame.minX
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
            
        }
    }
    
    /// y == 上
    var y : CGFloat {
        get{
            return self.frame.minX
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
            
        }
    }
    
    /// 左坐标
    var gy_left : CGFloat {
        get{
            return self.frame.minX
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
            
        }
    }
    
    
    /// 右坐标
    var gy_right : CGFloat {
        get{
            return self.frame.maxX
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    
    /// 上
    var gy_top : CGFloat {
        get{
            return self.frame.minY
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
            
        }
    }
    
    
    /// 下
    var gy_bootom: CGFloat {
        get{
            return self.frame.maxY
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    
    /// 宽
    var gy_width : CGFloat {
        
        get{
            return self.frame.width
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        
    }
    
    
    /// 高
    var gy_height: CGFloat {
        
        get{
            return self.frame.height
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
            
        }
        
    }
    
}

// MARK - snapShot
public extension UIView {
    
    func gy_snapShot() -> UIImage {
        
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let snapShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return snapShot
        
    }
    
}


