//
//  PersonInfoVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/12.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/12  下午1:10
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import DropDown
import ObjectMapper
import RealmSwift
import IQKeyboardManager

struct RequstPersonInfoModel {
    
    var nameStr: String?
    var placeHodlerStr: String?
    var namefield: String = ""
    var isEnable: Bool?
    
}

class PersonInfoVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var tableView: UITableView!
    var customerInfoDic:[String:String]? = [:]
    var dataArr:[RequstPersonInfoModel] = []
    let dropDown1 = DropDown()
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDown3 = DropDown()
    let dropDown4 = DropDown()
    let dropDown5 = DropDown()
    
    var isRequest:Bool = false
    var totalNum:NSInteger = 19
    
    var block: ((_ bool:Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        instanceUI()
        initData()

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func instanceUI() {
        
        title = "工商信息"
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
        
        let model = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        customerInfoDic?["Company"] = model?.companyname
        customerInfoDic?["ApplyUserName"] = model?.applicantname
        customerInfoDic?["Product"] = model?.financingtype
        customerInfoDic?["ApplyUserPhone"] = model?.applicantmobile
        
//        ,RequstPersonInfoModel(nameStr: "主营业务年收入", placeHodlerStr: requstModel?.YearIncome, namefield: "YearIncome",isEnable:true) ,RequstPersonInfoModel(nameStr: "主营业务", placeHodlerStr: requstModel?.MojorBusiness, namefield: "MojorBusiness",isEnable:true)
        dataArr = [RequstPersonInfoModel(nameStr: "融资产品", placeHodlerStr: model?.financingtype, namefield: "0",isEnable:false),RequstPersonInfoModel(nameStr: "公司名称", placeHodlerStr: model?.companyname, namefield: "0",isEnable:false),RequstPersonInfoModel(nameStr: "申请人姓名", placeHodlerStr: model?.applicantname, namefield: "0",isEnable:false),RequstPersonInfoModel(nameStr: "申请人手机", placeHodlerStr: model?.applicantmobile, namefield: "0",isEnable:false),RequstPersonInfoModel(nameStr: "意向融资额度(人民币)", placeHodlerStr: requstModel?.Funding, namefield: "Funding",isEnable:true),RequstPersonInfoModel(nameStr: "融资期限", placeHodlerStr: requstModel?.Term, namefield: "Term",isEnable:true),RequstPersonInfoModel(nameStr: "营业执照编号", placeHodlerStr: requstModel?.LicenseNo, namefield: "LicenseNo",isEnable:true),RequstPersonInfoModel(nameStr: "经营性质", placeHodlerStr: requstModel?.BusinessNature == "" ? "公司" : requstModel?.BusinessNature, namefield: "BusinessNature",isEnable:true),RequstPersonInfoModel(nameStr: "经营场所", placeHodlerStr: requstModel?.Premises, namefield: "Premises",isEnable:true),RequstPersonInfoModel(nameStr: "邮编", placeHodlerStr: requstModel?.ZipCode, namefield: "ZipCode",isEnable:true),RequstPersonInfoModel(nameStr: "公司电话", placeHodlerStr: requstModel?.CompanyPhone, namefield: "CompanyPhone",isEnable:true),RequstPersonInfoModel(nameStr: "是否有关联企业", placeHodlerStr: requstModel?.isHaveAssociate == "有" ? requstModel?.isHaveAssociate : "无", namefield: "isHaveAssociate",isEnable:true),RequstPersonInfoModel(nameStr: "身份证号码", placeHodlerStr: requstModel?.IDNumber, namefield: "IDNumber",isEnable:true),RequstPersonInfoModel(nameStr: "法人住址固定电话", placeHodlerStr: requstModel?.Telephone, namefield: "Telephone",isEnable:true),RequstPersonInfoModel(nameStr: "联系地址", placeHodlerStr: requstModel?.Address, namefield: "Address",isEnable:true),RequstPersonInfoModel(nameStr: "电邮", placeHodlerStr: requstModel?.Email, namefield: "Email",isEnable:true),RequstPersonInfoModel(nameStr: "主营业务实际经营年限", placeHodlerStr: requstModel?.Experience, namefield: "Experience",isEnable:true),RequstPersonInfoModel(nameStr: "主营业务月营业额", placeHodlerStr:requstModel?.Quota, namefield: "Quota",isEnable:true),RequstPersonInfoModel(nameStr: "是否有主营业务外其他收入", placeHodlerStr: (requstModel?.IsHasOther == "1" ? "有" : "无"), namefield: "IsHasOther",isEnable:true)]
        
        if customerInfoDic?["isHaveAssociate"] == "有" {
            dataArr.insert(RequstPersonInfoModel(nameStr: "数量", placeHodlerStr:requstModel?.AssociateCount, namefield: "AssociateCount",isEnable:true), at: 12)
            dataArr.insert(RequstPersonInfoModel(nameStr: "关联企业名称", placeHodlerStr:requstModel?.Associate, namefield: "Associate",isEnable:true), at: 13)
            totalNum += 2
        }
        
        if customerInfoDic?["IsHasOther"] == "1" {
            
            dataArr.insert(RequstPersonInfoModel(nameStr: "行业", placeHodlerStr:requstModel?.OtherIndustry, namefield: "OtherIndustry",isEnable:true), at: (dataArr.count))
            dataArr.insert(RequstPersonInfoModel(nameStr: "年收入", placeHodlerStr:requstModel?.OtherIncome, namefield: "OtherIncome",isEnable:true), at: (dataArr.count))
            totalNum += 2
        }
        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    func changeTypeAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 666:
            dropDown1.show()

            break
        case 777:
            dropDown.show()

            break
        case 778:
            dropDown4.show()
            break
        case 779:
            dropDown5.show()
            break
        case 1000:
            dropDown3.show()

            break
        case 888:
            dropDown2.show()

            break
        default:
            break
        }
        
        
        
    }

    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: -  FillCustomerCellDelagete
    
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
    
    func sucessBtnAction() {
        
        let realm = try! Realm()
        
        Print(realm.configuration.fileURL)
        
        let items = realm.objects(RequestRealm.self)
        
        if items.count>0 {
            
            try! realm.write {

            let requstModel = realm.object(ofType: RequestRealm.self, forPrimaryKey: "requestRealmID")
            Print(requstModel)
                
            save(requstModel!, isFirst: false)
            }
            return
        }
        
     
        
//        let  requstModel = RequestRealm()
//        
//        save(requstModel,isFirst: true)
//        
//        try! realm.write {
//            realm.add(requstModel)
//
//        }
        
//        let json = try! JSONSerialization.data(withJSONObject: customerInfoDic!, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let str = String(data:json, encoding: String.Encoding.utf8)!
//        
//        GYNetWorking.default.requestJson(GYRouter.submitUserInfoDetaile(parameters: ["usermsg":str]), sucess: { (data) in
//            
//            let json = data as? [String:AnyObject]
//            
//            let tmp = Mapper<FillCResultModel>().map(JSON: json!)
//            let vc = QuotaSureVc(nibName: "QuotaSureVc", bundle: nil)
//           
//            self.navigationController?.pushViewController(vc, animated: true)
//            
//        }) { (error) in
//            Print(error)
//        }
        
        
    }

    fileprivate func saveInfoDic(_ requstModel:RequestRealm?) {
        
        
        if requstModel?.Funding != "" {
            customerInfoDic?["Funding"] = requstModel?.Funding
        }
        
        if requstModel?.Term != ""{
            customerInfoDic?["Term"] = requstModel?.Term
        }
        
        if requstModel?.LicenseNo != "" {
            customerInfoDic?["LicenseNo"] = requstModel?.LicenseNo
        }
        
        if requstModel?.BusinessNature != "" {
            customerInfoDic?["BusinessNature"] = requstModel?.BusinessNature
        }
        
        if requstModel?.Premises != "" {
            customerInfoDic?["Premises"] = requstModel?.Premises
        }
        
        if requstModel?.ZipCode != "" {
            customerInfoDic?["ZipCode"] = requstModel?.ZipCode
        }
        
        if requstModel?.CompanyPhone != "" {
            customerInfoDic?["CompanyPhone"] = requstModel?.CompanyPhone
        }
        
        if requstModel?.Associate != "" {
            customerInfoDic?["Associate"] = requstModel?.Associate
        }
        
        if requstModel?.IDNumber != "" {
            customerInfoDic?["IDNumber"] = requstModel?.IDNumber
        }
        
        if requstModel?.Telephone != "" {
            customerInfoDic?["Telephone"] = requstModel?.Telephone
        }
        
        if requstModel?.Address != "" {
            customerInfoDic?["Address"] = requstModel?.Address
        }
        
        if requstModel?.Quota != "" {
            customerInfoDic?["Quota"] = requstModel?.Quota
        }
        
        if requstModel?.Experience != "" {
            customerInfoDic?["Experience"] = requstModel?.Experience
        }
        
        if requstModel?.MojorBusiness != "" {
            customerInfoDic?["MojorBusiness"] = requstModel?.MojorBusiness
        }
        
//        if requstModel?.AnnualIncome != "" {
//            customerInfoDic?["AnnualIncome"] = requstModel?.AnnualIncome
//        }
        
        if requstModel?.IsHasOther != "" {
            customerInfoDic?["IsHasOther"] = requstModel?.IsHasOther
        }
        
        if requstModel?.YearIncome != "" {
            customerInfoDic?["YearIncome"] = requstModel?.YearIncome
        }
        
        if requstModel?.Email != "" {
            customerInfoDic?["Email"] = requstModel?.Email
        }
        
        if requstModel?.isHaveAssociate != "" {
            customerInfoDic?["isHaveAssociate"] = requstModel?.isHaveAssociate
        }
        
        if requstModel?.AssociateCount != "" {
            customerInfoDic?["AssociateCount"] = requstModel?.AssociateCount
        }
        
        if requstModel?.OtherIncome != "" {
            customerInfoDic?["OtherIncome"] = requstModel?.OtherIncome
        }
        
        if requstModel?.OtherIndustry != "" {
            customerInfoDic?["OtherIndustry"] = requstModel?.OtherIndustry
        }
    }
    
    fileprivate func save(_ requstModel:RequestRealm,isFirst:Bool)  {
        
        if isFirst {
            
            requstModel.requestRealmID = "requestRealmID"
            
        }
        
        requstModel.Funding = customerInfoDic?["Funding"] ?? ""
        requstModel.Term = customerInfoDic?["Term"] ?? ""
        requstModel.LicenseNo = customerInfoDic?["LicenseNo"] ?? ""
        requstModel.BusinessNature = customerInfoDic?["BusinessNature"] ?? ""
        requstModel.Premises = customerInfoDic?["Premises"] ?? ""
        requstModel.ZipCode = customerInfoDic?["ZipCode"] ?? ""
        requstModel.CompanyPhone = customerInfoDic?["CompanyPhone"] ?? ""
        requstModel.Associate = customerInfoDic?["Associate"] ?? ""
        requstModel.IDNumber = customerInfoDic?["IDNumber"] ?? ""
        requstModel.Telephone = customerInfoDic?["Telephone"] ?? ""
        requstModel.Address = customerInfoDic?["Address"] ?? ""
        requstModel.Quota = customerInfoDic?["Quota"] ?? ""
        requstModel.Experience = customerInfoDic?["Experience"] ?? ""
        requstModel.MojorBusiness = customerInfoDic?["MojorBusiness"] ?? ""
//        requstModel.AnnualIncome = customerInfoDic?["AnnualIncome"] ?? ""
        requstModel.IsHasOther = customerInfoDic?["IsHasOther"] ?? ""
        requstModel.isHaveAssociate = customerInfoDic?["isHaveAssociate"] ?? ""
//        requstModel.OtherAnnualIncome = customerInfoDic?["OtherAnnualIncome"] ?? ""
        requstModel.Email = customerInfoDic?["Email"] ?? ""
        requstModel.OtherIncome = customerInfoDic?["OtherIncome"] ?? ""
        requstModel.OtherIndustry = customerInfoDic?["OtherIndustry"] ?? ""
        requstModel.AssociateCount = customerInfoDic?["AssociateCount"] ?? ""
        requstModel.YearIncome = customerInfoDic?["YearIncome"] ?? ""
        UserDefaults.standard.setValue(customerInfoDic, forKey: "PersonInfoKey")
        UserDefaults.standard.synchronize()

        guard (customerInfoDic?.count)! >= totalNum else {
            
            self.noticeOnlyText("已保存,但信息内容不全")
            
            self.perform(#selector(PersonInfoVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            if let block1 = block {
                block1(false)
               
            }
    
            return
        }
        
        let realm = try! Realm()
        //bankTypeInfoRealmID
        let model = realm.object(ofType: BankTypeInfoRealm.self, forPrimaryKey: "bankTypeInfoRealmID")
        if model != nil {
        
        if requstModel.Funding == ""  {
            requstModel.Funding = "0"
        }
            
        let money = Int(requstModel.Funding)
            
        if money! > Int((model?.moneyLimit)!)! {
            
            self.noticeOnlyText("意向融资额度不能大于" + (model?.moneyLimit)!)
            return
        }
        
        if money! < 10000 {
            self.noticeOnlyText("意向融资额度不能小于1万")
            return
        }
        }
        
        if !Tools.checkIdentity(requstModel.IDNumber) {
            self.noticeOnlyText("请检查身份证号是否有误")
            return
        }
        
        if !Tools.checkZipCode(requstModel.ZipCode) {
            self.noticeOnlyText("请检查邮编是否有误")
            return
        }
        
        if !Tools.checkEmail(requstModel.Email) {
         
            self.noticeOnlyText("请检查邮箱是否有误")
            return
        }
        
    
        self.noticeOnlyText("已保存")
        self.perform(#selector(PersonInfoVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
        if let block1 = block {
            block1(true)
        }
    }
    
    
    func popVc() {
        
        navigationController?.popViewController(animated: true)

    }
    
    //MARK: - Setter Getter Methods
    
    private lazy var  bootomBtn: UIButton = {
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 50, width: 211, height: 48), imageName: nil, title: "保存", target: self, action: #selector(PersonInfoVc.sucessBtnAction))
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

extension PersonInfoVc: UITableViewDelegate,UITableViewDataSource,FillCustomerCellDelagete {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 45)
        view.backgroundColor = UIColor.white
        let lb = UILabel()
        lb.frame = CGRect(x: 20, y: 15, width: Screen_Width, height: 20)
        lb.text = "工商信息"
        lb.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(lb)
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 5 {
            
                
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 1000
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            if model.placeHodlerStr == nil {
                model.placeHodlerStr = "6个月"
            }
            
            cell.textField.text = model.placeHodlerStr == "" ? "6个月" : model.placeHodlerStr
            customerInfoDic?["Term"] = cell.textField.text
            dropDown3.anchorView = cell
            dropDown3.direction = .any
            dropDown3.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown3.backgroundColor = UIColor.white
            dropDown3.dataSource = ["6个月","12个月"]
            dropDown3.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
            
            dropDown3.selectionAction = {[weak self] (index: Int, item: String) in
                
                cell.textField.text = item
                model.placeHodlerStr = item
                self?.dataArr[5] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["Term"] = item

            }
            
            return cell
        }
        
        if  indexPath.row == 7{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 666
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            if model.placeHodlerStr == nil {
                model.placeHodlerStr = "公司"
            }
            
            cell.textField.text = model.placeHodlerStr == "" ? "公司" : model.placeHodlerStr
            customerInfoDic?["BusinessNature"] = cell.textField.text
            dropDown1.anchorView = cell
            dropDown1.direction = .any
            dropDown1.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown1.backgroundColor = UIColor.white
            dropDown1.dataSource = ["公司", "个体工商户","个人独资企业","其他"]
            dropDown1.cellNib = UINib(nibName: "DropMyCell", bundle: nil)

            dropDown1.selectionAction = {[weak self] (index: Int, item: String) in

                cell.textField.text = item
                model.placeHodlerStr = item
                self?.dataArr[7] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["BusinessNature"] = item
            }
            
            return cell
            
        }
        
        if  indexPath.row == 11{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 777
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.textField.text = model.placeHodlerStr
            customerInfoDic?["isHaveAssociate"] = model.placeHodlerStr
            dropDown.anchorView = cell
            dropDown.direction = .any
            dropDown.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown.backgroundColor = UIColor.white
            dropDown.dataSource =  ["无","有"]
            dropDown.cellNib = UINib(nibName: "DropMyCell", bundle: nil)

            dropDown.selectionAction = {[weak self] (index: Int, item: String) in

                if item == cell.textField.text {
                    return
                }
                cell.textField.text = item
                model.placeHodlerStr = item
                
                if item == "有" {
                    self?.dataArr.insert(RequstPersonInfoModel(nameStr: "数量", placeHodlerStr:"", namefield: "AssociateCount",isEnable:true), at: 12)
                    self?.dataArr.insert(RequstPersonInfoModel(nameStr: "关联企业名称", placeHodlerStr:"", namefield: "Associate",isEnable:true), at: 13)
                    self?.totalNum += 2
                }
                
                if item == "无" {
                    let model = self?.dataArr[12]
                    if model?.nameStr == "数量" {
                        self?.dataArr.remove(at: 12)
                        self?.dataArr.remove(at: 12)
                        self?.customerInfoDic?.removeValue(forKey: "AssociateCount")
                        self?.customerInfoDic?.removeValue(forKey: "Associate")
                    }
                    self?.totalNum -= 2
                }
                
                self?.dataArr[11] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["isHaveAssociate"] = item
            }
            
            return cell
            
        }
        
        var dataArrcount = dataArr.count - 1
        if dataArr[dataArr.count - 1].nameStr == "年收入" {
            
            dataArrcount = dataArrcount - 2
            
        }
        
        if  indexPath.row == dataArrcount - 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 778
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            if model.placeHodlerStr == nil || model.placeHodlerStr == "" {
                model.placeHodlerStr = "0-6个月"
            }
            
            cell.textField.text = model.placeHodlerStr
            customerInfoDic?["Experience"] = model.placeHodlerStr
            dropDown4.anchorView = cell
            dropDown4.direction = .any
            dropDown4.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown4.backgroundColor = UIColor.white
            dropDown4.dataSource =  ["0-6个月","小于一年","1-3年","3-5年","5年以上"]
            dropDown4.cellNib = UINib(nibName: "DropMyCell", bundle: nil)

            dropDown4.selectionAction = {[weak self] (index: Int, item: String) in

                if item == cell.textField.text {
                    return
                }
                cell.textField.text = item
                model.placeHodlerStr = item

                self?.dataArr[dataArrcount - 2] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["Experience"] = item

            }
            
            return cell
            
        }

        if  indexPath.row == dataArrcount - 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 779
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            if model.placeHodlerStr == nil || model.placeHodlerStr == "" {
                model.placeHodlerStr = "10万以内"
            }
            
            cell.textField.text = model.placeHodlerStr
            customerInfoDic?["Quota"] = model.placeHodlerStr
            dropDown5.anchorView = cell
            dropDown5.direction = .any
            dropDown5.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown5.backgroundColor = UIColor.white
            dropDown5.dataSource =  ["10万以内","10万-30万","30万-50万","50万以上"]
            dropDown5.cellNib = UINib(nibName: "DropMyCell", bundle: nil)

            dropDown5.selectionAction = {[weak self] (index: Int, item: String) in
                if item == cell.textField.text {
                    return
                }
                cell.textField.text = item
                model.placeHodlerStr = item
            
                
                self?.dataArr[dataArrcount - 1] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["Quota"] = item
                
 
            }
            
            return cell
            
        }

        
        
        if  indexPath.row == dataArrcount{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.tag = 888
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.textField.text = model.placeHodlerStr
            customerInfoDic?["IsHasOther"] = (model.placeHodlerStr == "有" ? "1" : "0")
            dropDown2.anchorView = cell
            dropDown2.direction = .any
            dropDown2.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown2.backgroundColor = UIColor.white
            dropDown2.dataSource =  ["无","有"]
            dropDown2.cellNib = UINib(nibName: "DropMyCell", bundle: nil)

            dropDown2.selectionAction = {[weak self] (index: Int, item: String) in

                if item == cell.textField.text {
                    return
                }
                cell.textField.text = item
                model.placeHodlerStr = item
                
                if item == "有" {
                    self?.dataArr.insert(RequstPersonInfoModel(nameStr: "行业", placeHodlerStr:"", namefield: "OtherIndustry",isEnable:true), at: (self?.dataArr.count)!)
                    self?.dataArr.insert(RequstPersonInfoModel(nameStr: "年收入", placeHodlerStr:"", namefield: "OtherIncome",isEnable:true), at: (self?.dataArr.count)!)
                    self?.dataArr[(self?.dataArr.count)! - 3] = model
                    self?.totalNum += 2

                }
                
                if item == "无" {
                    let model1 = self?.dataArr.last
                    if model1?.nameStr == "年收入" {
                        self?.dataArr.remove(at:(self?.dataArr.count)! - 1)
                        self?.dataArr.remove(at: (self?.dataArr.count)! - 1)
                        self?.dataArr[(self?.dataArr.count)! - 1] = model
                        self?.customerInfoDic?.removeValue(forKey: "OtherIndustry")
                        self?.customerInfoDic?.removeValue(forKey: "OtherIncome")
                    }
                    self?.totalNum -= 2
                    
                }
                
                self?.tableView.reloadData()
                self?.customerInfoDic?["IsHasOther"] = (item == "有" ? "1" : "0")
                
            }
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FillCustomerCellID") as! FillCustomerCell
        cell.delegate = self
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row] as RequstPersonInfoModel
        
        cell.reloadRequestUI(model,row:indexPath.row)
        
        if indexPath.row == 4 {
            cell.nameTextField.becomeFirstResponder()
        }
        
//        cell.nameTextField.isEnabled = isRequest
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
        
    }
    
    

    
}

