//
//  ConfirmBtnView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/2.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/2  下午2:16
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

@objc protocol ConfirmBtnViewDelegate {
    
    func selectedBtn(_ tag: Int)
    
}

class ConfirmBtnView: UIView {


    weak var delegate: ConfirmBtnViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    fileprivate func initUI() {
        
        let btn = UIButton.init(CGRect(x: 60, y: 0, width: (Screen_Width - 140) * 0.4, height: self.gy_height), imageName: nil, title: "重新核算", target: self, action: #selector(btnAction(_:)))
        btn.tag = 666
        btn.backgroundColor = UIColor.init(134, g: 145, b: 185, a: 1.0)
        addSubview(btn)
        
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
//        btn.isEnabled = false
        
        let btn1 = UIButton.init(CGRect(x: btn.gy_right + 20, y:0 , width: (Screen_Width - 140) * 0.6, height: self.gy_height), imageName: nil, title: "立即申请融资", target: self, action: #selector(btnAction(_:)))
        btn1.tag = 777
        btn1.backgroundColor = UIColor.init(110, g: 160, b: 125, a: 1.0)
        addSubview(btn1)
        
        btn1.layer.cornerRadius = 8
        btn1.layer.masksToBounds = true
        btn1.setTitleColor(UIColor.white, for: UIControlState.normal)
//        btn1.isEnabled = false
        
    }
    
    func btnAction(_ sender:UIButton) {
     
        delegate?.selectedBtn(sender.tag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
