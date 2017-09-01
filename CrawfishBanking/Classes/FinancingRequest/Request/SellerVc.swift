//
//  SellerVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/13.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/13  下午2:04
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import IQKeyboardManager
import RealmSwift
import DropDown

class SellerVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var tableView: UITableView!
    var customerInfoDic:[String:String]? = [:]
    var dataArr:[RequstPersonInfoModel] = []
    var appendAarr:[RequstPersonInfoModel] = []
    var block: ((_ bool:Bool) -> ())?
    let dropDown1 = DropDown()
    
    var isRequest:Bool = false
    var totalNum:NSInteger = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instanceUI()
        initData()
        
    }
    
    //MARK: - Override
    
    //MARK: - Initial Methods
    fileprivate func instanceUI() {
        
        title = "经营信息"
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
        
        tableView.register(UINib.init(nibName: "FillBootomView", bundle: nil), forCellReuseIdentifier: "FillBootomViewID")
    }
    
    fileprivate func initData() {
        
        let realm = try! Realm()
        
        let requstModel = realm.object(ofType: RequestRealm.self, forPrimaryKey: "requestRealmID")
        if requstModel != nil {
            
            saveInfoDic(requstModel)
            
        } else {
            let model = RequestRealm()
            model.requestRealmID = "requestRealmID"
            
            try! realm.write {
                realm.add(model)
            }
            
        }
        dataArr = [RequstPersonInfoModel(nameStr: "开户名称", placeHodlerStr: requstModel?.BankUserName ?? "", namefield: "BankUserName",isEnable:true),RequstPersonInfoModel(nameStr: "开户行", placeHodlerStr: requstModel?.BankName, namefield: "BankName",isEnable:true),RequstPersonInfoModel(nameStr: "账户", placeHodlerStr: requstModel?.BankCardID, namefield: "BankCardID",isEnable:true),RequstPersonInfoModel(nameStr: "信用卡数量", placeHodlerStr: (requstModel?.CardCount == "" ? "无" : requstModel?.CardCount), namefield: "CardCount",isEnable:true),RequstPersonInfoModel(nameStr: "信用卡数量", placeHodlerStr: requstModel?.CardCount, namefield: "CardCount12",isEnable:true)]
        
        
        //,RequstPersonInfoModel(nameStr: "信用卡剩余总额度", placeHodlerStr: requstModel?.TotalSurplus, namefield: "TotalSurplus",isEnable:true)
        appendAarr = [RequstPersonInfoModel(nameStr: "最高额度信用卡开卡行", placeHodlerStr: requstModel?.HighestCardBank , namefield: "HighestCardBank",isEnable:true),RequstPersonInfoModel(nameStr: "信用卡单卡最高额度", placeHodlerStr: requstModel?.HighestLimit, namefield: "HighestLimit",isEnable:true),RequstPersonInfoModel(nameStr: "信用卡总额度", placeHodlerStr: requstModel?.TotalAmount, namefield: "TotalAmount",isEnable:true)]
        if !(customerInfoDic?["CardCount"] == "无") && customerInfoDic?["CardCount"] != nil{
            dataArr.append(contentsOf: appendAarr)
            totalNum += 3
        }
        
    }
    
    fileprivate func saveInfoDic(_ requstModel:RequestRealm?) {
        
        if requstModel?.BankUserName != "" {
            customerInfoDic?["BankUserName"] = requstModel?.BankUserName
        }
        
        if requstModel?.BankName != "" {
            customerInfoDic?["BankName"] = requstModel?.BankName
        }
        if requstModel?.BankCardID != "" {
            customerInfoDic?["BankCardID"] = requstModel?.BankCardID
        }
        if requstModel?.CardCount != "" {
            customerInfoDic?["CardCount"] = requstModel?.CardCount
        }
        if requstModel?.HighestCardBank != "" {
            customerInfoDic?["HighestCardBank"] = requstModel?.HighestCardBank
        }
        if requstModel?.HighestLimit != "" {
            customerInfoDic?["HighestLimit"] = requstModel?.HighestLimit
        }
        if requstModel?.TotalAmount != "" {
            customerInfoDic?["TotalAmount"] = requstModel?.HighestLimit
        }
        if requstModel?.TotalSurplus != "" {
            customerInfoDic?["TotalSurplus"] = requstModel?.TotalSurplus
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
        
        requstModel.BankUserName = customerInfoDic?["BankUserName"] ?? ""
        requstModel.BankName = customerInfoDic?["BankName"] ?? ""
        requstModel.BankCardID = customerInfoDic?["BankCardID"] ?? ""
        requstModel.CardCount = customerInfoDic?["CardCount"] ?? ""
        
        requstModel.HighestCardBank = customerInfoDic?["HighestCardBank"] ?? ""
        requstModel.HighestLimit = customerInfoDic?["HighestLimit"] ?? ""
        requstModel.TotalAmount = customerInfoDic?["TotalAmount"] ?? ""
        requstModel.TotalSurplus = customerInfoDic?["TotalSurplus"] ?? ""
        
        UserDefaults.standard.setValue(customerInfoDic, forKey: "SellerKey")
        UserDefaults.standard.synchronize()
        
        guard (customerInfoDic?.count)! >= totalNum else {
            
            self.noticeOnlyText("已保存,但信息内容不全")
            
            self.perform(#selector(SellerVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            if let block1 = block {
                block1(false)
                
            }
            
            return
        }
        
        self.noticeOnlyText("已保存")
        self.perform(#selector(SellerVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
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
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 50, width: 211, height: 48), imageName: nil, title: "保存", target: self, action: #selector(SellerVc.sucessBtnAction))
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
}

extension SellerVc: UITableViewDelegate,UITableViewDataSource,FillCustomerCellDelagete {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: section == 0 ? 40 : 50)
        view.backgroundColor = section == 0 ? UIColor.white : tableViewBgC
        if section == 1 {
            let view1 = UIView()
            view1.frame = CGRect(x: 0, y: 10, width: Screen_Width, height: 40)
            view1.backgroundColor = UIColor.white
            view.addSubview(view1)
            
        }
        let lb = UILabel()
        lb.frame = CGRect(x: 20, y: section == 0 ? 15 : 25, width: Screen_Width, height: 20)
        if section == 0 {
            lb.text = "收款账户"
        } else {
            lb.text = "信用卡信息"
        }
        lb.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(lb)
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 55)
            view.backgroundColor = tableViewBgC
            let view1 = UIView()
            view1.frame = CGRect(x: 0, y: 10, width: Screen_Width, height: 45)
            view1.backgroundColor = UIColor.white
            view.addSubview(view1)
            let lb = UILabel()
            lb.frame = CGRect(x: 20, y: 25, width: Screen_Width, height: 20)
            lb.text = "信用卡信息"
            lb.font = UIFont.systemFont(ofSize: 14)
            view.addSubview(lb)
            cell.contentView.addSubview(view)
            return cell
            
        }
        
        if indexPath.row == 4 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
                cell.selectionStyle = .none
                var model = dataArr[indexPath.row]
                cell.reloadRequestUI(model)
                cell.changeType.tag = 666
                cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
                
                cell.textField.text = model.placeHodlerStr == "" ? "无" : model.placeHodlerStr
                customerInfoDic?["CardCount"] = cell.textField.text
                dropDown1.anchorView = cell
                dropDown1.direction = .any
                dropDown1.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
                dropDown1.backgroundColor = UIColor.white
                dropDown1.dataSource = ["无", "1-5","5-10","10-20","大于20"]
                dropDown1.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
 
                dropDown1.selectionAction = {[weak self] (index: Int, item: String) in
         
                    if cell.textField.text == item {
                        return
                    }
                    
                    if item == "无" {
                        
                        self?.dataArr[5...7].removeAll()
                        self?.totalNum -= 3
                        
                    } else {
                        
                        if self?.dataArr.count == 5 {
                            self?.dataArr.append(contentsOf: (self?.appendAarr)!)
                            self?.totalNum += 3
                        }
                        
                    }
                    
                    cell.textField.text = item
                    model.placeHodlerStr = item
                    self?.dataArr[4] = model
                    self?.tableView.reloadData()
                    let typeNum = item
//                    if item == "其他" {
//                        typeNum = "4"
//                    }
                    self?.customerInfoDic?["CardCount"] = typeNum
      
                }
                
                return cell
                
        }
            
        
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
        
        if indexPath.row == 3 {
            return 50
        }
        
        return 45
        
    }
    
    func changeTypeAction(_ sender: UIButton) {
        
        dropDown1.show()
        
    }

    
    
    
}


