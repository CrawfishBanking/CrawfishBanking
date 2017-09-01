//
//  InvitePepVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/26.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/26  下午2:15
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class InvitePepVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var textField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的邀请人"
        view.backgroundColor = tableViewBgC
        
        GYNetWorking.default.requestJson(GYRouter.getMyInviter(parameters:["it_action":"select","it_code":""]), sucess: {[weak self] (data) in
            let json = data["data"] as? [String:AnyObject]

            let codeStr = json?["it_code"] as? String
            if codeStr == nil || codeStr == ""{
                self?.initUI(false, phone: nil)
            } else {
                self?.initUI(true, phone: json?["it_code"] as? String)
            }
            Print(data)
        }) { (error) in
            Print(error)
        }
    
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI(_ isTrue: Bool,phone:String?) {
        
        let view1 = UIView()
        view1.frame = CGRect(x: 15, y: 15, width: Screen_Width - 30, height: 50)
        view1.backgroundColor = UIColor.white
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        view.addSubview(view1)
        
        let lb = UILabel()
        lb.frame = CGRect(x: 15, y: 15, width: 100, height: 20)
        lb.text = "手机号"
        lb.font = UIFont.systemFont(ofSize: 21)
        lb.textColor = UIColor.init(hexColor: "999999")
        view1.addSubview(lb)
        
        textField = UITextField(frame: CGRect(x: 130, y: 15, width: view1.gy_width - 145, height: 20))
        textField.becomeFirstResponder()
        textField.textAlignment = .right
        textField.textColor = UIColor.init(hexColor: "333333")
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.keyboardType = .numberPad
        textField.isEnabled = !isTrue
        textField.text = phone
        view1.addSubview(textField)
        if !isTrue {
          
            view.addSubview(bootomBtn)
            bootomBtn.backgroundColor = navBarColor
            
        }

        

        
    }
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    func sucessBtnAction() {

        let isPhone = Tools.checkPhoneNumber(textField.text!)
        if !isPhone {

            self.noticeOnlyText("请输入正确的手机号")
            return
        }

        
        GYNetWorking.default.requestJson(GYRouter.getMyInviter(parameters:["it_action":"add","it_code":textField.text!]), sucess: {[weak self] (data) in
  
            DispatchQueue.main.async {
                
                self?.noticeOnlyText("提交成功！")
                
            }
            
            self?.perform(#selector(InvitePepVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            
        
            
            self?.navigationController?.popViewController(animated: true)
        }) { (error) in
            Print(error)
//            self.noticeOnlyText("提交失败！")
        }
        
    }
    
    //MARK: - Notification Methods
    func popVc() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    private lazy var  bootomBtn: UIButton = {
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 280, width: 211, height: 48), imageName: nil, title: "提交", target: self, action: #selector(InvitePepVc.sucessBtnAction))
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
