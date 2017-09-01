//
//  FriendInfoVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/13.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/13  下午2:05
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import IQKeyboardManager
import RealmSwift

class FriendInfoVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var tableView: UITableView!
    var customerInfoDic:[String:String]? = [:]
    var dataArr:[RequstPersonInfoModel] = []
    var block: ((_ bool:Bool) -> ())?
    var isRequest:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instanceUI()
        initData()

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    fileprivate func instanceUI() {
        
        title = "亲友信息"
        
        if isRequest {
            bootomBtn.isHidden = isRequest
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64),style:.grouped)
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = tableViewBgC
        view.addSubview(tableView)
        
        let bootomView = UIView()
        
        bootomView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 300)
        bootomBtn.backgroundColor = navBarColor
        bootomBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        bootomView.addSubview(bootomBtn)
        
        tableView.tableFooterView = bootomView
        
        tableView.register(UINib.init(nibName: "FillCustomerCell", bundle: nil), forCellReuseIdentifier: "FillCustomerCellID")
        
    }
    
    fileprivate func initData() {
        
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: RequestRealm.self, forPrimaryKey: "requestRealmID")
        if requstModel != nil {
            
            saveInfoDic(requstModel)
            
        } else {
            let model = RequestRealm()
//            let userStr = UserDefaults.standard.value(forKey: userPhone) as! String
            
            model.requestRealmID = "requestRealmID"
            
            try! realm.write {
                realm.add(model)
            }
            
        }
        dataArr = [RequstPersonInfoModel(nameStr: "姓名", placeHodlerStr: requstModel?.FName ?? "", namefield: "FName",isEnable:true),RequstPersonInfoModel(nameStr: "手机", placeHodlerStr: requstModel?.FPhone, namefield: "FPhone",isEnable:true),RequstPersonInfoModel(nameStr: "联系地址", placeHodlerStr: requstModel?.FAddress, namefield: "FAddress",isEnable:true),RequstPersonInfoModel(nameStr: "固定电话", placeHodlerStr: requstModel?.FTelephone, namefield: "FTelephone",isEnable:true)]
        
    }
    
    fileprivate func saveInfoDic(_ requstModel:RequestRealm?) {
        
        if requstModel?.FName != "" {
            customerInfoDic?["FName"] = requstModel?.FName
        }
        
        if requstModel?.FPhone != "" {
            customerInfoDic?["FPhone"] = requstModel?.FPhone
        }
        if requstModel?.FAddress != "" {
            customerInfoDic?["FAddress"] = requstModel?.FAddress
        }
        if requstModel?.FTelephone != "" {
            customerInfoDic?["FTelephone"] = requstModel?.FTelephone
        }

    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func sucessBtnAction() {
        
        let realm = try! Realm()
        try! realm.write {
        
        let requstModel = realm.object(ofType: RequestRealm.self, forPrimaryKey: "requestRealmID")
        Print(requstModel)
                
        save(requstModel!, isFirst: false)
            
        }
        

    }
    
    fileprivate func save(_ requstModel:RequestRealm,isFirst:Bool)  {
        
        if isFirst {
            
            requstModel.requestRealmID = "requestRealmID"
            
        }
        
        requstModel.FName = customerInfoDic?["FName"] ?? ""
        requstModel.FTelephone = customerInfoDic?["FTelephone"] ?? ""
        requstModel.FAddress = customerInfoDic?["FTelephone"] ?? ""
        requstModel.FPhone = customerInfoDic?["FPhone"] ?? ""
        
        UserDefaults.standard.setValue(customerInfoDic, forKey: "FriendInfoKey")
        UserDefaults.standard.synchronize()
        
        guard (customerInfoDic?.count)! >= 4 else {
            
            self.noticeOnlyText("已保存,但信息内容不全")
            
            self.perform(#selector(FriendInfoVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            if let block1 = block {
                block1(false)
                
            }
            
            return
        }
        
        if !Tools.checkPhoneNumber((customerInfoDic?["FPhone"])!) {
            self.noticeOnlyText("请输入正确的手机号码")
            return
        }
        
        self.noticeOnlyText("已保存")
        self.perform(#selector(FriendInfoVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
        if let block1 = block {
            block1(true)
        }
    }
    
    func popVc() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func inputString(_ str: String?, currentType: String?) {
        
        
        
        if !(str?.checkifNotNull())! {
            customerInfoDic?.removeValue(forKey: currentType!)
            self.noticeOnlyText("请输入内容")
            return
            
        }
        
        customerInfoDic?[currentType!] = str
        
    }
    
    
    func rowInfo(_ row: String?, str: String?) {
        
        var model  = dataArr[Int(row!)!]
        
        model.placeHodlerStr = str
        
        dataArr[Int(row!)!] = model
        
    }

    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    private lazy var  bootomBtn: UIButton = {
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 50, width: 211, height: 48), imageName: nil, title: "保存", target: self, action: #selector(FriendInfoVc.sucessBtnAction))
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        
        return btn
    }()
    
    
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

extension FriendInfoVc: UITableViewDelegate,UITableViewDataSource,FillCustomerCellDelagete {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 45)
        view.backgroundColor = UIColor.white
        let lb = UILabel()
        lb.frame = CGRect(x: 20, y: 15, width: Screen_Width, height: 20)
        lb.text = "非同住亲友信息"
        lb.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(lb)
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FillCustomerCellID") as! FillCustomerCell
        cell.delegate = self
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row] as RequstPersonInfoModel
        
        cell.reloadRequestUI(model,row:indexPath.row)
        
        if indexPath.row == 0 {
            cell.nameTextField.becomeFirstResponder()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
        
    }
    
    
    
    
}
