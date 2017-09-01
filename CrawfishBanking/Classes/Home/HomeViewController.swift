//
//  HomeViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/24.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/24  下午5:27
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift
import ObjectMapper

class HomeViewController: GYBaseViewController {
    
    //MARK: - Attributes
    
    var gyBanner: GYBanner!
    var bootomView: HomeBootomView!
    var dataList:[GYBannerModel] = []
    let imageList:[String] = ["1-1.png","1-1.png","1-2.png","1-3.png","1-4.png","1-5.png","1-6.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "小龙虾金融服务"
        
        instanceDatas()
        initUI()

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        gyBanner = GYBanner(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 1/2 * Screen_Width), imageHandle: { (index) in
            Print(index)
            
           let vc = JWPhotoBrowserViewController(photoCount: self.dataList.count, showIndex: index, thumbnailClosure: { (index, imageView, completionClosuree) in
            
                completionClosuree(UIImage(named: self.imageList[index]))
            
            
            }, bigImageClosure: { (index, imageView,completionClosure) in
                
                completionClosure(UIImage(named: self.imageList[index]))
                
            }, sourceViewClosure: { (index) in
                
                return (self.gyBanner,UIImage(named: self.imageList[index]))
               
            })
            
            self.present(vc, animated: true, completion: nil)
            
        })
        gyBanner.reloadGYBanner(dataList)
        view.addSubview(gyBanner)
        
        if Screen_Height == 480 {
            
          bootomView = HomeBootomView(frame: CGRect(x: 0, y: gyBanner.gy_bootom, width: view.bounds.size.width, height: Screen_Height - 1/2 * Screen_Width - 30))
            
            
        } else {
           
            bootomView = HomeBootomView(frame: CGRect(x: 0, y: 1/2 * Screen_Width + 30, width: view.bounds.size.width, height: Screen_Height - 1/2 * Screen_Width - 64 - 50))
            
        }
        

        bootomView.delegate = self
        view.addSubview(bootomView)
        
    }
    /**
     模拟数据
     */
    fileprivate func instanceDatas(){
        
        for i in 1...7 {
            
            let product = GYBannerModel()
            product.imageNamed = String(i) + ".png"
            
            product.labelText = String(i)
            dataList.append(product)
            
        }
        
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
        Print("申请销毁了")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: HomeBootomViewDelegate {
    
    func selectedButtonIndex(_ index: NSInteger) {
        
        switch index {
        case 0:
            navigationController?.pushViewController(SubmitViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(InviteHistory(), animated: true)
        case 3:
            loadUserInfo()
            
        default:
            self.noticeOnlyText("此功能尚未开放")
            break
            
        }
        
    }
    
    fileprivate func loadUserInfo() {
        
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        
        if requstModel == nil {
            let model = BankTypeInfoRealm()
            model.bankTypeInfoRealmID = "bankTypeInfoRealmID"
            model.isRequest = false
            try! realm.write {
                
                realm.add(model)
                
            }
        }
        
//        let requstModel1 = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        
//        guard !(requstModel1?.isRequest)! else {
//            // 未跳过 已申请
//            navigationController?.pushViewController(UserInfoVc(), animated: true)
//            return
//            
//        }
        
        GYNetWorking.default.requestJson(GYRouter.getUserInfo(parameters: [:]), sucess: { [weak self](data) in
            Print(data)
            let json = data["data"] as? [String:AnyObject]
            
            if json == nil {
                //跳过
              self?.navigationController?.pushViewController(UserInfoVc(), animated: true)
            } 
            
            let tmp = Mapper<UserModel>().map(JSON: json!)
            
            try! realm.write {
                
                let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
                requstModel?.applicantlevel = tmp?.applicantlevel ?? ""
                requstModel?.applicantmobile = tmp?.applicantmobile ?? ""
                requstModel?.applicantname = tmp?.applicantname ?? ""
                requstModel?.areacode = tmp?.areacode ?? ""
                requstModel?.companyname = tmp?.companyname ?? ""
                requstModel?.financingtype = tmp?.financingtype ?? ""
                requstModel?.moneyLimit = String(describing: tmp?.loanAmount ?? 0)
                requstModel?.isRequest = true
                
                var userType = "普通用户"
                switch (tmp?.usertype)! {
                case 0:
                    userType = "普通用户"
                    break
                case 1:
                    userType = "扶持经理"
                    break
                case 2:
                    userType = "浩泽代理商"
                    break
                default:
                    break
                }
                
                requstModel?.usertype = userType
                
            }
            
            self?.navigationController?.pushViewController(UserInfoVc(), animated: true)
            
        }) { (error) in
            
            if error.localizedDescription == "该用户未填写详细信息" {
                
                let realm = try! Realm()
                
                let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
                
                if requstModel == nil {
                    let model = BankTypeInfoRealm()
                    model.bankTypeInfoRealmID = "bankTypeInfoRealmID"
                    model.isRequest = false
                    try! realm.write {
                        
                        realm.add(model)
                        
                    }
                }
                
                try! realm.write {
                    
                    let requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
               
                    requstModel?.applicantlevel = ""
                    requstModel?.applicantmobile =  ""
                    requstModel?.applicantname = ""
                    requstModel?.areacode =  ""
                    requstModel?.companyname = ""
                    requstModel?.financingtype = ""
                    requstModel?.moneyLimit = "未知"
                    requstModel?.isRequest = false
                    requstModel?.financingtype = "未知"
                    
                    requstModel?.usertype = "普通用户"
                    
                }


              
                self.navigationController?.pushViewController(UserInfoVc(), animated: true)
                
            }
            
            Print(error)
        }
        
    }
    
}
