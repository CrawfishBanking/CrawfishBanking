//
//  UserInfoVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/18.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/18  上午9:25
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift

class UserInfoVc: GYBaseBackViewController {
    
    //MARK: - Attributes
//    var dataModel:(String,imgStr:String)!
    var userInfotopView: UserInfoTopView!
    var tableView: UITableView!
    
//    let dataArrs = [[["我的邀请人","我的邀请人"],["消息管理","消息管理--图标"],["关于我们","关于我们--图标"]],[["意见与建议","意见与建议--图标"],["退出登录","退出登录--图标"]]]
    let dataArrs = [[["我的邀请人","我的邀请人"],["关于我们","关于我们--图标"]],[["用户协议","意见与建议--图标"],["退出登录","退出登录--图标"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        self.title = "账户管理"
        
        self.navigationController?.navigationBar.setBackgroundImage(Tools.creatImageWithColor(color: UIColor.init(200, g: 31, b: 36, a: 1.0)), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        userInfotopView = UINib.init(nibName: "UserInfoTopView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! UserInfoTopView
        userInfotopView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 235)
        let phoneStr = UserDefaults.standard.value(forKey: userPhone) as? String ?? ""
        
        userInfotopView.phoneLb.setTitle(phoneStr, for: UIControlState.normal)
        userInfotopView.btn.addTarget(self, action: #selector(UserInfoVc.btnAction), for: UIControlEvents.touchUpInside)
        userInfotopView.btn2.addTarget(self, action: #selector(UserInfoVc.btnAction), for: UIControlEvents.touchUpInside)
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
    

        userInfotopView.oznertypeLb.text = requstModel?.usertype == "" ? "普通用户" : requstModel?.usertype
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = tableViewBgC
        tableView.tableHeaderView = userInfotopView
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
//        userInfotopView.quotaLb.text = "未知"

    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func btnAction() {
        
        if userInfotopView.quotaLb.text == "未知" {
        
//            let vc = FillCustomerViewController.init(true)
//            vc.rightBtnHide = true

            let vc = ProductTypeVc.init(true)
            
            navigationController?.pushViewController(vc, animated: true)

            return
        }
        
        let vc = FillCustomerViewController.init(false)
        vc.loadType = LoanType(rawValue: userInfotopView.typeLb.text!)
//        vc.loadType = LoanType.Finance
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        
        var moneyStr = requstModel?.moneyLimit == "" ? "未知" : requstModel?.moneyLimit

        if moneyStr != "未知" && (moneyStr?.checkifNotNull())!{
            moneyStr = "¥ " + Tools.formatNumberToMoney(Double(moneyStr!)!)
        }
        
        userInfotopView.quotaLb.text =  moneyStr
        userInfotopView.typeLb.text = requstModel?.financingtype == "" ? "未知" : requstModel?.financingtype
        
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


}


extension UserInfoVc: UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoVcCellID")
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "UserInfoVcCellID")
            cell?.selectionStyle = .none
            let lb = UILabel(frame: CGRect(x: 40, y: 13, width: 200, height: 20))
            
            lb.textColor = UIColor.init(hexColor: "333333")
            lb.tag = 666
            lb.font = UIFont.systemFont(ofSize: 15)
            cell?.contentView.addSubview(lb)
            
            let view = UIView(frame: CGRect(x: 40, y: 40, width: Screen_Width - 40, height: 1))
            view.backgroundColor = tableViewBgC
            
            cell?.contentView.addSubview(view)
            
            let image = UIImageView(frame: CGRect(x: 15, y: 13, width: 16.5, height: 18.5))
            image.tag = 777
            cell?.contentView.addSubview(image)
            
        }
        
        let arr = dataArrs[indexPath.section][indexPath.row]
        
        let lb = cell?.viewWithTag(666) as! UILabel
        
        lb.text = arr[0]
        
        let image = cell?.viewWithTag(777) as! UIImageView
        image.image = UIImage(named: arr[1])
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        switch indexPath {
        case IndexPath.init(row: 0, section: 0):
            
            let vc = InvitePepVc()
            
            navigationController?.pushViewController(vc, animated: true)
            
            break
        case IndexPath.init(row: 1, section: 0):
            
            let vc = AboutCrawfishVc(nibName: "AboutCrawfishVc", bundle: nil)
            
            navigationController?.pushViewController(vc, animated: true)
            
            break
        case IndexPath.init(row: 0, section: 1):
            
            let vc = ContractDetail()
            
            vc.urlStr = "http://appbanking.51xlx.com:8660/App/User/UserAgreement?id=1"
            vc.titleStr = "用户协议"
            navigationController?.pushViewController(vc, animated: true)
            
            break
        case IndexPath.init(row: 1, section: 1):
            
            let alert = UIAlertView()
            alert.title = "温馨提示"
            alert.message = "退出登录会清除缓存信息"
            alert.addButton(withTitle: "取消")
            alert.addButton(withTitle: "确定")
            alert.delegate = self
            alert.show()
            break
        default:
            break
        }
        
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            let realm = try! Realm()
         
            try! realm.write {
                realm.deleteAll()
            }
            UserAccount.deleateAccount()
            appDelegate.window?.rootViewController = LoginViewController()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(hexColor: "EBE9F0")
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
}
