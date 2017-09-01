//
//  GYIndicatorView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/28.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/28  下午4:20
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

@objc protocol GYIndicatorAnimationProtocol {
    
    func configAnimation(_ layer: CALayer,tintColor: UIColor,size: CGSize)
    func removeAnimation()
    
}

class GYIndicatorView: UIView ,CAAnimationDelegate{

    var animation:GYIndicatorAnimationProtocol?
    
    private var size: CGSize!
    
    private var color: UIColor!
    
    var isAnimating: Bool!
   
    init(_ frame: CGRect,tintColor:UIColor) {

        super.init(frame: frame)
        size = frame.size
        color = tintColor
        NotificationCenter.default.addObserver(self, selector: #selector(GYIndicatorView.appWillEnterBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GYIndicatorView.appWillBecomeActive), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    func startAnimating() {
        
        self.layer.sublayers = nil
        setToNormalState()

        animation = GYBounceSportAnimation()
        
        if (self.animation != nil) {
        
            animation?.configAnimation(self.layer, tintColor: self.color, size: size)
            
        }
        self.isAnimating = true
    }
    
    func stopAnimating() {
        
        if self.isAnimating {
            
            if (self.animation != nil) {
               self.animation?.removeAnimation()
                self.isAnimating = false
                self.animation = nil
            }
            
        }
        fadeOutWithAnimation(true)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    fileprivate func setToNormalState() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.speed = 1.0
        self.layer.opacity = 1.0
    }
    
    fileprivate func setToFadeOutState() {
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.sublayers = nil
        self.layer.opacity = 0.0
        
    }
    
    fileprivate func fadeOutWithAnimation(_ animated: Bool) {
        
        if animated {
            
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.delegate = self
            fadeAnimation.beginTime = CACurrentMediaTime()
            fadeAnimation.duration = 0.35
            fadeAnimation.toValue = 0
            self.layer.add(fadeAnimation, forKey: "fadeOut")
            
        }
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        setToFadeOutState()
        
    }
    
    func appWillEnterBackground() {
        
        if self.isAnimating {
          self.animation?.removeAnimation()
        }
        
    }
    
    func appWillBecomeActive() {
     
        if self.isAnimating {
            startAnimating()
        }
    }
    
    deinit {

        Print(self)
        if self.isAnimating {
            self.animation?.removeAnimation()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

