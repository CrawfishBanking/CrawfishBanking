//
//  RequestVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/3.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/3  下午2:48
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift
import ObjectMapper

struct RequestModel {

    var titleName:String?
    var state:String?
}

class RequestVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var tableView: UITableView!

    var personInfoModelArr:[FillCustomerModel] = []
    var isRequest:Bool = false
    
    var type: Bool = true
    
    var requestModelArr:[RequestModel] = [] {
        
        didSet {
            tableView.reloadData()
        }
    }
    var personInfoUpDic:[String:String] = [:]
    var shopInfoDic:[String:String] = [:]
    var sellerInfoDic:[String:String] = [:]
    var friendInfoDic:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "贷款信息填写"
      
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 125))

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let bootomView = UIView()
        bootomView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 120)
        bootomBtn.backgroundColor = UIColor.init(246, g: 122, b: 128, a: 1.0)
        bootomBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        bootomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bootomBtn.isEnabled = false
        bootomView.addSubview(bootomBtn)
        tableView.tableFooterView = bootomView
        view.addSubview(tableView)

        tableView.register(UINib.init(nibName: "RequestMainCell", bundle:nil), forCellReuseIdentifier: NSStringFromClass(RequestMainCell.self))
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
        if requstModel == nil {
            
            let model = RequestStateModel()
            model.requestStateID = "requestStateID"
            
            try! realm.write {
                realm.add(model)
            }
            
        }
        
        requestModelArr = [RequestModel(titleName: "工商信息", state: requstModel?.personInfo ?? "0"),RequestModel( titleName: "门店资料", state: requstModel?.shopType ?? "0"),RequestModel( titleName: "经营信息", state: requstModel?.sellerInfo ?? "0"),RequestModel(titleName: "非同住亲友信息", state: requstModel?.friendInfo ?? "0")]
        checkIfCanSubmit()
    }
    
    //MARK: - Override
    
    
    
    //MARK: - Initial Methods
    
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func sucessBtnAction() {
        

//        str = str.replacingOccurrences(of: "\n", with: "")
        
        let alert = UIAlertView()
        alert.title = "温馨提示"
        alert.message = "提交后暂时无法查看所提交信息,请确认所填信息无误!"
        alert.addButton(withTitle: "取消")
        alert.addButton(withTitle: "确定")
        alert.delegate = self
        alert.show()
        
    }
    
    func popVc() {
        
        ///后面改
        if type {
            navigationController?.popViewController(animated: true)
//            navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        } else {
            appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
        }
        
//        navigationController?.popViewController(animated: true)
        
    }
    

    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    fileprivate func checkIfCanSubmit() {
        
        if isRequest {
            
            bootomBtn.setTitle("已提交", for: UIControlState.normal)
            bootomBtn.isEnabled = false
            
            return
        }
        
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
        
        if (((requstModel?.friendInfo) == "1")&&(requstModel?.personInfo == "1")&&((requstModel?.shopType) == "1")&&(requstModel?.sellerInfo == "1")){
            bootomBtn.isEnabled = true
            bootomBtn.backgroundColor = navBarColor
        } else {
            bootomBtn.isEnabled = false
            bootomBtn.backgroundColor = UIColor.init(246, g: 122, b: 128, a: 1.0)
        }
        
        
    }

    
    //MARK: - Privater Methods
    private lazy var  bootomBtn: UIButton = {
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 40, width: 211, height: 48), imageName: nil, title: "提交", target: self, action: #selector(RequestVc.sucessBtnAction))
        
        btn.layer.cornerRadius = 24
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    //MARK: - Setter Getter Methods
    
    override func backAction() {
        if self.type {
            navigationController?.popViewController(animated: true)
        } else {
            appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
        }
    }
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

}

extension RequestVc: UITableViewDataSource,UITableViewDelegate ,UIAlertViewDelegate{
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            
            var dic1 = UserDefaults.standard.value(forKey: "PersonInfoKey") as! [String:String]
            
            dic1["Term"] = (dic1["Term"] == "6个月" ? "6" : "12")
            
            let dic2 = UserDefaults.standard.value(forKey: "ShopTypeKey") as! [String:String]
            
            var dic3 = UserDefaults.standard.value(forKey: "SellerKey") as! [String:String]
            if dic3["CardCount"] == "其他" {
                dic3["CardCount"] = "4"
            }
            
            if dic3["CardCount"] == "无" {
                dic3["CardCount"] = "0"
            }
            
            let dic4 = UserDefaults.standard.value(forKey: "FriendInfoKey") as! [String:String]
            dic1 += dic2
            dic1 += dic3
            dic1 += dic4
            Print(dic1)
            //        dic1.removeValue(forKey: "RentStartTime")
            //        dic1["RentStartTime"] = "2017-06-14"
            //        dic1.removeValue(forKey: "RentEndTime")
            //        dic1.removeValue(forKey: "OpeningTime")
            //        dic1["StoreCount"] = "2"
            //        dic1["BusinessArea"] = "123"
            //        dic1["Staff"] = "3"
            //        dic1["Monthly"] = "13"
            let json = try! JSONSerialization.data(withJSONObject: dic1, options: JSONSerialization.WritingOptions.prettyPrinted)
            let str = String(data:json, encoding: String.Encoding.utf8)!
            
            GYNetWorking.default.requestJson(GYRouter.submitApplication(parameters: ["data" : str]), sucess: { [weak self] (data) in
                
                let _ = data as? [String:AnyObject]
                self?.noticeOnlyText("提交成功")
                
                self?.perform(#selector(RequestVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])

                
            }) { (error) in
                Print(error)
                
//                DispatchQueue.main.async {
//                    self.noticeOnlyText("提交成功")
// 
//                }
//                
//                
//                self.perform(#selector(RequestVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            }
            

            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return requestModelArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(RequestMainCell.self)) as! RequestMainCell
        let model = requestModelArr[indexPath.row]
        cell.selectionStyle = .none
        
        cell.reloadRequestUI(model)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            let vc = PersonInfoVc()
            
            vc.block = {[weak self] (bool:Bool) in

            self?.reloadData(0, bool: bool)
    
            }
            navigationController?.pushViewController(vc, animated: true)

            break
        case 1:
            let vc = ShopTypeVc()
            
            vc.block = {[weak self] (bool:Bool) in
                
                self?.reloadData(1, bool: bool)
                
            }
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = SellerVc()
            vc.block = {[weak self] (bool:Bool) in
                
                self?.reloadData(2, bool: bool)
                
            }
            navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = FriendInfoVc()
            vc.block = {[weak self] (bool:Bool) in
                
                self?.reloadData(3, bool: bool)
                
            }
            navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
        
    }
    
    func reloadData(_ index:Int,bool:Bool) {
        
        let realm = try! Realm()
        
        switch index {
        case 0:
            DispatchQueue.main.async {
                
                try! realm.write {
                    let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
                    Print(requstModel)
                    requstModel?.personInfo = bool ? "1" : "0"
                    self.checkIfCanSubmit()
                }
            }
            break
        case 1:
            DispatchQueue.main.async {
                
                try! realm.write {
                    let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
                    requstModel?.shopType = bool ? "1" : "0"
                    self.checkIfCanSubmit()
                }
            }
            break
        case 2:
            DispatchQueue.main.async {
                try! realm.write {
                    let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
                    Print(requstModel)
                    requstModel?.sellerInfo = bool ? "1" : "0"
                    self.checkIfCanSubmit()
                }
            }
        case 3:
            
            DispatchQueue.main.async {
            try! realm.write {
                let requstModel = realm.object(ofType: RequestStateModel.self, forPrimaryKey: "requestStateID")
                Print(requstModel)
                requstModel?.friendInfo = bool ? "1" : "0"
                self.checkIfCanSubmit()
            }
            }
       
            break
        default:
            break
        }
        
        var model = requestModelArr[index]
        model.state = bool ? "1" : "0"
        requestModelArr[index] = model
        
        
     
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 68
    }
    
}
