//
//  GYBounceSportAnimation.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/28.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/28  下午5:14
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYBounceSportAnimation: NSObject, GYIndicatorAnimationProtocol{
    
    private var spotLayer:CALayer?

    func configAnimation(_ layer: CALayer,tintColor: UIColor,size: CGSize) {
        
        let replicatorLayer = CAReplicatorLayer()
        
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        replicatorLayer.position = CGPoint(x: 0, y: 0)
        replicatorLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(replicatorLayer)
        
        addCyclingSpotAnimationLayer(replicatorLayer, tintColor: tintColor, size: size)
        
        let numFloat = 15.0
        replicatorLayer.instanceCount = Int(numFloat)
        let angle = (Double.pi * 2.0)/numFloat
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
        replicatorLayer.instanceDelay = 1.5/numFloat
        
      
    }
    
    func removeAnimation() {
        
        self.spotLayer?.removeAnimation(forKey: "animation")
        
    }
    
    fileprivate func addCyclingSpotAnimationLayer( _ layer: CALayer,tintColor: UIColor,size: CGSize) {
        
        self.spotLayer = CALayer()
        self.spotLayer?.bounds = CGRect(x: 0, y: 0, width: size.width/4, height: size.height/4)
//        self.spotLayer?.position = CGPoint(x: size.width, y: size.height)
        self.spotLayer?.cornerRadius = (self.spotLayer?.bounds.size.width)!/2
        self.spotLayer?.backgroundColor = tintColor.cgColor
        self.spotLayer?.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        layer.addSublayer(self.spotLayer!)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 0.5
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        
        self.spotLayer?.add(animation, forKey: "animation")
        
    }

}
