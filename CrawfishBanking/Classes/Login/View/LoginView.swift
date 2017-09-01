//
//  LoginView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午5:13
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import SnapKit

class LoginView: UIView,UITextFieldDelegate {

    var phoneImage: UIImageView?
    var phoneTextField: UITextField!
    var lineView: UIView!
    var pwdImage: UIImageView?
    var pwdTextField: UITextField!
    var inviteImage: UIImageView?
    var invitePhone: UITextField!
    var lineView3: UIView!
    var lineView2: UIView!
    var timerBtn:GYTimerButton!
    
    let lineViewEditColor = UIColor.init(hexColor: "d81d1d")
    let lineViewColor = UIColor.init(hexColor: "333333")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        instanceUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginView.changText), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
    }
    
    func changText() {
        
        timerBtn.phoneStr = phoneTextField.text ?? ""
        
    }
    
    fileprivate func instanceUI() {
        
        phoneTextField = UITextField()
        self.addSubview(phoneTextField)
        phoneTextField.delegate = self
        phoneTextField.placeholder = "手机号码"
        let phoneStr = UserDefaults.standard.value(forKey: userPhone) as? String ?? ""
        phoneTextField.text = phoneStr
        phoneTextField.keyboardType = .numberPad
        phoneTextField.font = UIFont.systemFont(ofSize: 14.0)
        phoneTextField.clearButtonMode = .whileEditing
        phoneImage = UIImageView()
        self.addSubview(phoneImage!)
        phoneImage?.image = UIImage(named: "login_user")
        
        lineView = UIView()
        self.addSubview(lineView)
        lineView.backgroundColor = lineViewEditColor
        
        pwdTextField = UITextField()
        self.addSubview(pwdTextField)
        pwdTextField.delegate = self
        pwdTextField.placeholder = "验证码"
//        pwdTextField.text = "123456"
        //        pwdTextField.borderStyle = .roundedRect
        pwdTextField.keyboardType = .numberPad
        pwdTextField.font = UIFont.systemFont(ofSize: 14.0)
        
        pwdImage = UIImageView()
        self.addSubview(pwdImage!)
        pwdImage?.image = UIImage(named: "login_lock")
        
        timerBtn = GYTimerButton(CGRect.zero, timerNumber: 60)
        self.addSubview(timerBtn)
        timerBtn.phoneStr = phoneStr
        lineView2 = UIView()
        self.addSubview(lineView2)
        lineView2.backgroundColor = lineViewColor
        
        inviteImage = UIImageView()
        self.addSubview(inviteImage!)
        inviteImage?.image = UIImage(named: "邀请人手机号")
        
        invitePhone = UITextField()
        self.addSubview(invitePhone)
        invitePhone.placeholder = "邀请人手机号"
        invitePhone.font = UIFont.systemFont(ofSize: 14.0)
        invitePhone.delegate = self
        invitePhone.keyboardType = .numberPad
        invitePhone.isEnabled = true
        lineView3 = UIView()
        self.addSubview(lineView3)
        lineView3.backgroundColor = lineViewColor
        
        
        phoneImage?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.leading.equalTo(69)
            make.width.equalTo(17)
            make.height.equalTo(25)
        })
        
        pwdImage?.snp.makeConstraints({ (make) in
            make.top.equalTo((phoneImage?.snp.bottom)!).offset(30)
            make.leading.equalTo(67)
            make.width.equalTo(21)
            make.height.equalTo(25)
        })
        
        inviteImage?.snp.makeConstraints({ (make) in
            make.top.equalTo((pwdImage?.snp.bottom)!).offset(30)
            make.leading.equalTo(67)
            make.width.equalTo(21)
            make.height.equalTo(25)
        })
        
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo((phoneImage?.snp.top)!)
            make.leading.equalTo((phoneImage?.snp.trailing)!).offset(10)
            make.trailing.equalTo(-69)
            make.height.equalTo((phoneImage?.snp.height)!)
        }
        
        pwdTextField.snp.makeConstraints { (make) in
            make.top.equalTo((pwdImage?.snp.top)!).offset(2)
            make.leading.equalTo(phoneTextField.snp.leading)
            make.height.equalTo(phoneTextField.snp.height)
            make.width.equalTo(phoneTextField.snp.width).multipliedBy(0.4)
        }
        
        invitePhone.snp.makeConstraints { (make) in
            
            make.top.equalTo((inviteImage?.snp.top)!).offset(2)
            make.leading.equalTo(phoneTextField.snp.leading)
            make.height.equalTo(phoneTextField.snp.height)
            make.trailing.equalTo(phoneTextField.snp.trailing)
            
        }
    
        timerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pwdTextField.snp.top)
            make.trailing.equalTo(phoneTextField.snp.trailing)
            make.width.equalTo(101)
            make.height.equalTo(phoneTextField.snp.height)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo((phoneImage?.snp.bottom)!).offset(10)
            make.height.equalTo(1)
            make.leading.equalTo((phoneImage?.snp.leading)!)
            make.trailing.equalTo(phoneTextField.snp.trailing)
        }
        
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo((pwdImage?.snp.bottom)!).offset(10)
            make.height.equalTo(1)
            make.leading.equalTo((pwdImage?.snp.leading)!)
            make.trailing.equalTo(timerBtn.snp.trailing)
        }
        
        lineView3.snp.makeConstraints { (make) in
            make.top.equalTo((inviteImage?.snp.bottom)!).offset(10)
            make.height.equalTo(1)
            make.leading.equalTo((phoneImage?.snp.leading)!)
            make.trailing.equalTo(phoneTextField.snp.trailing)
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        lineView.backgroundColor = phoneTextField.isEditing ? lineViewEditColor :lineViewColor
        
        lineView2.backgroundColor = pwdTextField.isEditing ? lineViewEditColor : lineViewColor
   
        lineView3.backgroundColor = invitePhone.isEditing ? lineViewEditColor : lineViewColor
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == phoneTextField {
            
            UserDefaults.standard.set(phoneTextField.text, forKey: userPhone)
            UserDefaults.standard.synchronize()
            
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    
}
