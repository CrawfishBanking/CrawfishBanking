//
//  GYTimerButton.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午4:29
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import Alamofire

class GYTimerButton: UIButton {

    var timer: Timer!
    var timeInterval:Int = 0
    var timeSum:Int!
    var phoneStr:String = ""
    init(_ frame: CGRect,timerNumber:Int) {
        super.init(frame: frame)
        timeInterval = timerNumber
        timeSum = timerNumber
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.setTitle("发送短信验证码", for: UIControlState.normal)
        self.setTitleColor(UIColor.init(hexColor: "333333"), for: UIControlState.normal)
        self.backgroundColor = UIColor.init(hexColor: "ffd724")
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true
        self.addTarget(self, action: #selector(GYTimerButton.btnAction), for: .touchUpInside)
    }
    
    
    /// 倒计时
    ///
    /// - Parameters:
    ///   - frame: frame description
    ///   - timerNumber: timerNumber description
    ///   - title: title description
//    init(_ frame: CGRect,timerNumber:Int,title: String) {
//        super.init(frame: frame)
//        timeInterval = timerNumber
//        timeSum = timerNumber
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        self.setTitle(title, for: UIControlState.normal)
//        self.setTitleColor(UIColor.init(hexColor: "333333"), for: UIControlState.normal)
//        self.backgroundColor = UIColor.init(hexColor: "ffd724")
//        self.layer.cornerRadius = 13
//        self.layer.masksToBounds = true
//        btnAction()
//        //        self.addTarget(self, action: #selector(GYTimerButton.btnAction), for: .touchUpInside)
//    }
    
    
    func btnAction() {
        
//        let phoneStr = UserDefaults.standard.value(forKey: userPhone) as? String ?? ""
        
        if !Tools.checkPhoneNumber(phoneStr) {
            self.noticeOnlyText("请输入正确的手机号码")
            return
        }
        
        GYNetWorking.default.requestJson(GYRouter.getPhoneCode(parameters: ["mobile":phoneStr,"use":"login"]), sucess: {
            [weak self](data) in
            
            DispatchQueue.main.async {

                self?.noticeOnlyText("验证码已发送")
                self?.isEnabled = false
                self?.timer = Timer.scheduledTimer(timeInterval: 1, target: self!, selector: #selector(GYTimerButton.timerAction), userInfo: nil, repeats: true)
                RunLoop.current.add((self?.timer)!, forMode: RunLoopMode.defaultRunLoopMode)
            }
            
        }) { (error) in
            
        }
        
    }
    
    func timerAction() {
        self.setTitle("\(timeInterval)秒", for: UIControlState.normal)
        timeInterval -= 1
        if timeInterval < 0 {
            DispatchQueue.main.async(execute: {
                
                self.setTitle("发送短信验证码", for: UIControlState.normal)
                self.timeInterval = self.timeSum
                
            })
            self.isEnabled = true
            timer.invalidate()
            timer = nil
            return
        }
        
    }
    
    deinit {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
