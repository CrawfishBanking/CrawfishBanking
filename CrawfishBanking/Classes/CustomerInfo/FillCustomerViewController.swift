//
//  FillCustomerViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/27.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/27  上午10:38
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import DropDown
import ObjectMapper
import IQKeyboardManager
import RealmSwift

enum LoanType: String {
    
    case ToJion = "加盟宝"
    case Finance = "货款宝"

}
class FillCustomerViewController: GYBaseBackViewController {
    
    //MARK: - Attributes
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var activityView: GYIndicatorView!
    var headView: FillHeadView!
    var loadType: LoanType!
    var tableView: UITableView!
    var typeBool: Bool = true
    var pushBool:Bool = true
    var currentLevel: String = "Level A"
    var rightBtnHide:Bool = false
    var requstModel:BankTypeInfoRealm?
    var isFirst:Bool = true
    var isrevise:Bool = false
    
    var customerInfoDic:[String:String]? = [:]
    
    var dataArr:[FillCustomerModel] = [] {
        
        didSet {
            tableView.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
        initUI()

        
    }
    
    //MARK: - Override
    
    convenience  init(_ type:Bool) {
        self.init()
        typeBool = type
        pushBool = type
        
    }
    
    //MARK: - Initial Methods
    fileprivate func initUI() {
        headView = UINib.init(nibName: "FillHeadView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! FillHeadView
        if typeBool {
            title = loadType.rawValue
            if !rightBtnHide {
                navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem(nil, title: "跳过", target: self, action: #selector(FillCustomerViewController.rightItemAction))
              }
        } else {
            title = "客户信息"
            navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem(nil, title: "修改", target: self, action: #selector(FillCustomerViewController.rightItemAction))
            headView.titleLb.text = "融资产品"
        }
        
//        loadType = LoanType.ToJion
       
        tableView = UITableView(frame: view.frame)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = tableViewBgC

        view.addSubview(tableView)

       
        headView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 56)
        headView.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
        headView.changeType.isEnabled = typeBool
        headView.changeType.tag = 666
//        tableView.tableHeaderView = headView
        let bootomView = UIView()
        
        bootomView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 300)
        bootomBtn.backgroundColor = UIColor.init(hexColor: "999999")
        bootomBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        bootomView.addSubview(bootomBtn)
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 0.5 * Screen_Width))
        image.image = loadType.rawValue == "加盟宝" ? UIImage(named: "3.jpg") : UIImage(named: "7.jpg")

        tableView.tableHeaderView = image
        tableView.tableFooterView = bootomView
        tableView.tableFooterView?.isHidden = !typeBool
        dropDown.anchorView = headView
        dropDown.direction = .any

        let appearance = DropDown.appearance()
        appearance.backgroundColor = UIColor.white
        weak var weakSelf = self
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)

        dropDown.dataSource = ["加盟宝", "货款宝"]
        dropDown.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
        dropDown.cancelAction = { () -> Void in
         
            UIView.animate(withDuration: 0.5, animations: {
                
                weakSelf?.headView.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
                
            })
        }

        dropDown.selectionAction = {[weak self]
            (index: Int, item: String) in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                weakSelf?.headView.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
                
                
            })
            
            guard weakSelf?.headView.textField.text != item else {
                return
            }
            self?.isFirst = false
            weakSelf?.headView.textField.text = item
            
            switch index {
            case 0:
                self?.loadType = LoanType.ToJion
                self?.customerInfoDic?["applicantlevel"] = "Level A"
            case 1:
                self?.loadType = LoanType.Finance
                self?.customerInfoDic?.removeValue(forKey: "applicantlevel")
            default:
                break
            }
            self?.customerInfoDic?["financingtype"] = self?.loadType.rawValue
            
            if (self?.customerInfoDic?.count)! >= 5 {
                
                self?.bootomBtn.backgroundColor = navBarColor
//                self?.bootomBtn.isEnabled = true
            
            }
            
            self?.initData()
        }

        tableView.register(UINib.init(nibName: "FillCustomerCell", bundle: nil), forCellReuseIdentifier: "FillCustomerCellID")
        //FillBootomViewID
        tableView.register(UINib.init(nibName: "FillBootomView", bundle: nil), forCellReuseIdentifier: "FillBootomViewID")
        initData()
        
//        activityView = GYIndicatorView.init(CGRect(x: 50, y: 100, width: 60, height: 60), tintColor: UIColor.blue)
//        view.addSubview(activityView)
//
//        activityView.startAnimating()
        
        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    func rightItemAction() {
        
        if typeBool {
            appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
            
            self.dismiss(animated: true, completion: nil)
        } else {
//            typeBool = true
//            pushBool = false
//            navigationItem.rightBarButtonItem = nil
//            bootomBtn.setTitle("完成,重新核算", for: UIControlState.normal)
//            bootomBtn.backgroundColor = navBarColor
//            headView.changeType.isEnabled = typeBool
//            tableView.tableFooterView?.isHidden = !typeBool
//            tableView.reloadData()
            UserDefaults.standard.set(0, forKey: "isPushSubMit")
            UserDefaults.standard.synchronize()
            
            let vc = ProductTypeVc.init(true)
            vc.isRevise = true
            
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
    }
    
    func changeTypeAction(_ sender: UIButton) {
        
           
        UIView.animate(withDuration: 0.5, animations: {
            
            sender.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
                
        })
        
       
        if sender.tag == 666 {
            dropDown.show()
            return
        }
        
        dropDown1.show()
    
    }
    
    func sucessBtnAction() {
        
//        self.present(GYNavigationController(rootViewController: ConfirmViewController()), animated: false, completion: nil)
        
        guard (customerInfoDic?.count)! >= 5 else {
            
            self.noticeOnlyText("请补全内容")
            return
        }
        
        if  !Tools.checkPhoneNumber((customerInfoDic?["applicantmobile"])!) {
            self.noticeOnlyText("请输入正确的手机号码")
            return
        }
        
        let json = try! JSONSerialization.data(withJSONObject: customerInfoDic!, options: JSONSerialization.WritingOptions.prettyPrinted)
        let str = String(data:json, encoding: String.Encoding.utf8)!
        
        GYNetWorking.default.requestJson(GYRouter.submitUserInfoDetaile(parameters: ["usermsg":str]), sucess: {[weak self] (data) in
            
            let json = data as? [String:AnyObject]
            guard (json != nil) else {
                return
            }
//            let tmp = Mapper<FillCResultModel>().map(JSON: json!)
            Print(json?["data"]!)
            let money = json?["data"] as? String ?? "未知"
            let realm = try! Realm()
            
            try! realm.write {
                
                self?.requstModel?.applicantlevel = self?.customerInfoDic?["applicantlevel"] ?? ""
                self?.requstModel?.applicantmobile = self?.customerInfoDic?["applicantmobile"] ?? ""
                self?.requstModel?.applicantname = self?.customerInfoDic?["applicantname"] ?? ""
                self?.requstModel?.areacode = self?.customerInfoDic?["areacode"] ?? ""
                self?.requstModel?.companyname = self?.customerInfoDic?["companyname"] ?? ""
                self?.requstModel?.financingtype = self?.customerInfoDic?["financingtype"] ?? ""
                self?.requstModel?.isRequest = true
//                self?.requstModel?.moneyLimit = String(describing: tmp?.data ?? 0)
                self?.requstModel?.moneyLimit =  money
            }
//            Print(tmp?.data)
            
            let vc = QuotaSureVc(nibName: "QuotaSureVc", bundle: nil)
//            vc.loadMesg = (typeStr: self?.loadType.rawValue,numStr: String(describing: tmp?.data ?? 0) ) as? (typeStr: String, numStr: String)
              vc.loadMesg = (typeStr: self?.loadType.rawValue,numStr: money) as? (typeStr: String, numStr: String)
            
            if (self?.isrevise)! {
                
                vc.isRevese = true
                self?.navigationController?.pushViewController(vc, animated: true)
                return
            }

            if !(self?.rightBtnHide)! {
                self?.present(vc, animated: false, completion: nil)
            } else {
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
        }) { (error) in
            Print(error)
        }
        
    }
    
    //MARK: - Notification Methods
    
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    fileprivate func initData() {
        dataArr.removeAll()
        
        let realm = try! Realm()
        
        requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        
        if requstModel == nil {
            let model = BankTypeInfoRealm()
            model.bankTypeInfoRealmID = "bankTypeInfoRealmID"
            model.isRequest = false
            try! realm.write {
                
                realm.add(model)
                
            }
        }
        
        requstModel = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        
        if isFirst {

            headView.textField.text = requstModel?.financingtype == "" ? "货款宝" : requstModel?.financingtype

        }
        
//        loadType = LoanType.init(rawValue: requstModel?.financingtype == "" ? "货款宝" : (requstModel?.financingtype)!)
        customerInfoDic?["financingtype"] = loadType.rawValue

        if !pushBool {
            let zero = FillCustomerModel(nameStr: "融资产品", placeHodlerStr: requstModel?.financingtype,namefield: "financingtype")
            dataArr.append(zero)
        }

        let one = FillCustomerModel(nameStr: "公司名称", placeHodlerStr: requstModel?.companyname,namefield: "companyname")
        let two = FillCustomerModel(nameStr: "申请人姓名", placeHodlerStr: requstModel?.applicantname,namefield:"applicantname")
        let three = FillCustomerModel(nameStr: "申请人手机", placeHodlerStr: requstModel?.applicantmobile,namefield:"applicantmobile")
        var four = FillCustomerModel()
        if loadType == LoanType.Finance {
            
            four  = FillCustomerModel(nameStr: "区域代码", placeHodlerStr: requstModel?.areacode,namefield:"areacode")
        } else {
            four = FillCustomerModel(nameStr: "申请加盟等级", placeHodlerStr:requstModel?.applicantlevel == "" ? "Level A" : requstModel?.applicantlevel ,namefield:"applicantlevel")
        }
        
        dataArr.append(one)
        dataArr.append(two)
        dataArr.append(three)
        if loadType == LoanType.ToJion {
            dataArr.append(four)
        } else {
            dataArr.append(four)
            
        }
        
        if !pushBool {
            
            var moneyStr = requstModel?.moneyLimit
            
            if moneyStr != "未知" && (moneyStr?.checkifNotNull())!{
                moneyStr = "¥ " + Tools.formatNumberToMoney(Double(moneyStr!)!)
            }
            
            let five = FillCustomerModel(nameStr: "核定融资额度", placeHodlerStr: moneyStr,namefield:"applicantmobile123")
            dataArr.append(five)
            
        }
    
    }
    
    //MARK: - Setter Getter Methods
    
    override func backAction() {
        
        if pushBool {
            self.dismiss(animated: true, completion: nil)
        }
        
        if !pushBool || rightBtnHide{
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK: -  FillCustomerCellDelagete
    
    func inputString(_ str: String?, currentType: String?) {
        
        if !(str?.checkifNotNull())! {
            customerInfoDic?.removeValue(forKey: currentType!)
            self.noticeOnlyText("请输入内容")
            return
            
        }
        
        customerInfoDic?[currentType!] = str
        
        if (customerInfoDic?.count)! >= 5 {
            
            bootomBtn.backgroundColor = navBarColor
            bootomBtn.isEnabled = true
            
        }
        
    }

    
    private lazy var  bootomBtn: UIButton = {
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 90, width: 211, height: 48), imageName: nil, title: "核算额度", target: self, action: #selector(FillCustomerViewController.sucessBtnAction))
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true

       return btn
    }()
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared().isEnabled = true
//        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        IQKeyboardManager.shared().isEnabled = false
//        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = false
        
    }

    deinit {
        Print(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FillCustomerViewController: UITableViewDelegate,UITableViewDataSource,FillCustomerCellDelagete {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 && loadType == LoanType.ToJion && title != "客户信息"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            let model = dataArr[indexPath.row] as FillCustomerModel
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            if !pushBool {
                cell.changeType.isEnabled = typeBool
            }
            customerInfoDic?["applicantlevel"] = requstModel?.applicantlevel == "" ? "Level A" : requstModel?.applicantlevel
            cell.reloadUI(model)
            dropDown1.anchorView = cell
            dropDown1.direction = .any
            
            dropDown1.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            
            dropDown1.dataSource = ["Level A", "Level B","Level C"]
            dropDown1.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
            dropDown1.cancelAction = { () -> Void in
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    cell.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
                    
                })
            }
            dropDown1.selectionAction = {[weak self] (index: Int, item: String) in
                UIView.animate(withDuration: 0.5, animations: {
                    
                    cell.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
                    
                    
                })
                    cell.textField.text = item
                    self?.currentLevel = item
                    self?.customerInfoDic?["applicantlevel"] = item
            }

            return cell
            
        }
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "FillCustomerCellID") as! FillCustomerCell
        cell.delegate = self
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row] as FillCustomerModel

        cell.nameTextField.isEnabled = typeBool
        
        if indexPath.row == 0 {
            cell.nameTextField.becomeFirstResponder()
        }
//        else {
//            cell.nameTextField.resignFirstResponder()
//        }
        
        //typeBool
        cell.reloadUI(model,isFillIn:!typeBool)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 56
        
    }
    
   
}
