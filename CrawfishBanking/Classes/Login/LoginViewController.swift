//
//  LoginViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午2:17
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import IQKeyboardManager

class LoginViewController: GYBaseViewController {
    
    //MARK: - Attributes
    var loginView: LoginView!
    var btn1:UIButton!
    var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        view.addSubview(Crawfishlogo)

        if Screen_Height == 480 {
           
            loginView = LoginView(frame: CGRect(x: 0, y: Screen_Height * 0.3, width: Screen_Width , height: 160))

            
        } else {
            
            loginView = LoginView(frame: CGRect(x: 0, y: Screen_Height * 0.45, width: Screen_Width , height: 160))
            
        }
        
        let valueisHide = UserDefaults.standard.object(forKey: "GYisFirstLogin") as? String
        
        var y_btn = loginView.gy_bootom + 8
        if valueisHide != nil && valueisHide != "" {
            
            y_btn = loginView.gy_bootom - 40
            loginView.inviteImage?.isHidden = true
            loginView.invitePhone.isHidden = true
            loginView.lineView3.isHidden = true
            
        }
        
        view.addSubview(loginView)
        
        btn1 = UIButton()
        btn1.frame = CGRect(x: 69, y: y_btn, width: 20, height: 20)
        btn1.setBackgroundImage(#imageLiteral(resourceName: "agree"), for: UIControlState.normal)
        btn1.setBackgroundImage(#imageLiteral(resourceName: "notagree"), for: UIControlState.selected)
        btn1.addTarget(self, action: #selector(LoginViewController.GYagreementAction(_:)), for: UIControlEvents.touchUpInside)

        view.addSubview(btn1)
        
        let btn = UIButton()
        
        var width = Screen_Width - 168
        if Tools.currenIphoneType() == EnumIphoneType.Iphone6p {
         
            width = width - 50
        }
        
        btn.frame = CGRect(x: btn1.gy_right + 5, y: y_btn, width: width, height: 20)
        btn.titleLabel?.textAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitle("我已阅读并同意小龙虾免责条款", for: UIControlState.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(LoginViewController.agreementAction), for: UIControlEvents.touchUpInside)
        btn.setTitleColor(UIColor.init(hexColor: "333333"), for: UIControlState.normal)
        view.addSubview(btn)
        
        loginBtn = UIButton(frame: CGRect(x: 82, y: Screen_Height * (1057/1334), width: Screen_Width - 164, height: 48))
        loginBtn.setTitle("登录", for: UIControlState.normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.layer.cornerRadius = 24
        loginBtn.backgroundColor = UIColor.init(hexColor: "d81d1d")
        loginBtn.layer.masksToBounds = true
        view.addSubview(loginBtn)
        
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginAction), for: UIControlEvents.touchUpInside)
        view.addSubview(oznerLb)
        
    }
    
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods

    func GYagreementAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    func agreementAction() {
        
        let vc = ContractDetail()
        
        vc.urlStr = "http://appbanking.51xlx.com:8660/App/User/UserAgreement?id=1"
        vc.titleStr = "用户协议"
        vc.isBool = false
        
        self.present(GYNavigationController(rootViewController: vc), animated: true, completion: nil)
        
    }
    
    func loginAction() {

        loginView.phoneTextField.resignFirstResponder()
        loginView.pwdTextField.resignFirstResponder()
        
        if btn1.isSelected {
            
            self.noticeOnlyText("请阅读并同意免责条款")
            return
        }
        
        let isPhone = Tools.checkPhoneNumber(loginView.phoneTextField.text!)
        if !isPhone {
//            gyShowInfoMessgae(nil, subTitle: "", actionSure: {
//                
//            }, actionCancle: { 
//                
//            })
            self.noticeOnlyText("请输入正确的手机号")
            return
        }
        
        if (loginView.invitePhone.text?.checkifNotNull())!{
            
            if !Tools.checkPhoneNumber(loginView.invitePhone.text!) {
                self.noticeOnlyText("请输入正确的邀请人手机号码或不填")
                return
            }
            
        }
        
        if !(loginView.pwdTextField.text?.checkifNotNull())! {
            self.noticeOnlyText("请输入验证码")
            return
        }
        
        GYNetWorking.default.requestJson(GYRouter.login(parameters: ["phonenumber":loginView.phoneTextField.text!,"vc_code":loginView.pwdTextField.text ?? "","it_code":loginView.invitePhone.text ?? ""]), sucess: { [weak self] (data)  in

            let json = data as? [String:AnyObject]
            
            UserAccount.deleateAccount()
            let account = UserAccount()
            account.acctoken = json?["msg"] as? String
            account.data = (json?["data"] as? Int)?.description
            account.phone = self?.loginView.phoneTextField.text
            account.status = (json?["status"] as? Int)?.description
            account.saveAccount()
            
            UserDefaults.standard.set("isFirstLogin", forKey: "GYisFirstLogin")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                
                if account.status == "1" {
                    
                    let vc = GYNavigationController(rootViewController: HomeViewController())
//                    self?.present(vc, animated: true, completion: nil)
                    appDelegate.window?.rootViewController = vc
                    
                } else {
                 
                    let vc = QuotaUnkownVc(LoanState.QuotaunKown)
                    self?.present(vc, animated: true, completion: nil)
                    
                }
                
            }
          
            }) { (error) in
                Print(error)
            }
        
//        let vc =  LoginNoneInfoVc(nibName: "LoginNoneInfoVc", bundle: nil)
//        let vc = QuotaUnkownVc(nibName: "QuotaUnkownVc", bundle: nil)

    }
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    private lazy var Crawfishlogo: UIImageView = {
        
        var y:CGFloat = 160
        if Screen_Height == 480 {
            y = 70
        }
        
        let lb = UIImageView(frame: CGRect(x: 0, y: y, width: Screen_Width, height: 67))
        lb.contentMode = .center
        lb.image = UIImage(named: "BankLogo")
        return lb
        
    }()
    
    private lazy var oznerLb: UIImageView = {
       
        let lb = UIImageView(frame: CGRect(x: 0, y: Screen_Height - 55, width: Screen_Width, height: 30))
        lb.contentMode = .center
        lb.image = UIImage(named: "OznerLogo")
        return lb
        
    }()
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = false
        
    }

    deinit {

       Print("销毁了")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
