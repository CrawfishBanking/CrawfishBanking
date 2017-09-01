//
//  ContractVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/3.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/3  下午2:50
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class ContractVc: GYBaseViewController {
    
    //MARK: - Attributes

    var urlStr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GYNetWorking.default.requestJson(GYRouter.compactInfo(parameters: [:]), sucess: { (data) in
//            
//            Print(data)
//        }) { (error) in
//            Print(error)
//        }
        
        view.backgroundColor = tableViewBgC
        let btn1 = createBtn(CGRect(x: 12.5, y: 15, width: Screen_Width - 25, height: 150), title: "保理合同", image: #imageLiteral(resourceName: "保理合同"))
        
//        btn1.backgroundColor = UIColor.blue
        view.addSubview(btn1)
        
        let btn2 = createBtn(CGRect(x: 12.5, y: btn1.gy_bootom + 15, width: Screen_Width - 25, height: 150), title: "框架协议", image: #imageLiteral(resourceName: "框架协议"))
        view.addSubview(btn2)
        btn1.tag = 666
        btn1.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
        btn2.tag = 777

        btn2.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
    }
    
    //MARK: - Override
    func btnAction(_ sender:UIButton) {
        
        let vc = ContractDetail()
        
        if sender.tag == 666 {
            vc.urlStr = "http://appbanking.51xlx.com:8660/App/User/AppCompactInfo" + "?usertoken=" + (UserAccount.loadAccount()?.acctoken)! + "&id=" + urlStr!
            vc.titleStr = "保理合同"
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        vc.urlStr = "http://appbanking.51xlx.com:8660/App/User/AgreementInfo" + "?usertoken=" + (UserAccount.loadAccount()?.acctoken)! + "&id=" + urlStr!
        vc.titleStr = "框架协议"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Initial Methods
    
    fileprivate func createBtn(_ frame:CGRect,title:String,image:UIImage) -> UIButton {
        
        let btn = UIButton()
        btn.setTitle(title, for: UIControlState.normal)
        btn.frame = frame
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(image, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.init(hexColor: "333333"), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        return btn
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
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
