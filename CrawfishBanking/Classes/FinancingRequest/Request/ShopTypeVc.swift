//
//  ShopTypeVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/13.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/13  下午1:56
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import IQKeyboardManager
import RealmSwift
import DropDown

class ShopTypeVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var tableView: UITableView!
    var customerInfoDic:[String:String]? = [:]
    var dataArr:[RequstPersonInfoModel] = []
    var selectedArr:[[String]] = []
    var block: ((_ bool:Bool) -> ())?
    let dropDown1 = DropDown()
    var dropaArr:[DropDown] = []
    var isBool:Bool = false
    var pickerView: GYDatePicker!
    var currentimePicker:Int!
    var isRequest:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instanceUI()
        initData()
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    fileprivate func instanceUI() {
        
        title = "门店资料"
        if isRequest {
            bootomBtn.isHidden = isRequest
        }
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64),style:.plain)
        
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
        tableView.register(UINib.init(nibName: "TimeCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(TimeCell.self))
        
    }
    
    fileprivate func initData() {
        
        customerInfoDic = UserDefaults.standard.value(forKey: "ShopTypeKey") as? [String : String] ?? [:]
        
        if (customerInfoDic?["StoreType"] == nil ? "无" :customerInfoDic?["StoreType"]) == "无"{
            isBool = false
        } else {
            isBool = true
        }
        
        dataArr = [RequstPersonInfoModel(nameStr: "门店资料", placeHodlerStr: customerInfoDic?["StoreType"] == nil ? "无" :customerInfoDic?["StoreType"], namefield: "666666",isEnable:true),RequstPersonInfoModel(nameStr: "经营名称(招牌名称)", placeHodlerStr: customerInfoDic?["ManageName"], namefield: "ManageName",isEnable:true),RequstPersonInfoModel(nameStr: "经营地址", placeHodlerStr: customerInfoDic?["ManageAddress"], namefield: "ManageAddress",isEnable:true),RequstPersonInfoModel(nameStr: "主营业务", placeHodlerStr: customerInfoDic?["MainBusiness"], namefield: "MainBusiness",isEnable:true),RequstPersonInfoModel(nameStr: "所属行业", placeHodlerStr: customerInfoDic?["Industry"], namefield: "Industry",isEnable:true),RequstPersonInfoModel(nameStr: "开业时间" , placeHodlerStr: customerInfoDic?["OpeningTime"]  == nil ? "点击选择时间" : customerInfoDic?["OpeningTime"], namefield: "OpeningTime",isEnable:true),RequstPersonInfoModel(nameStr: "门店个数", placeHodlerStr: customerInfoDic?["StoreCount"], namefield: "StoreCount",isEnable:true),RequstPersonInfoModel(nameStr: "营业面积(㎡)", placeHodlerStr: customerInfoDic?["BusinessArea"], namefield: "BusinessArea",isEnable:true),RequstPersonInfoModel(nameStr: "商户经营地段", placeHodlerStr: customerInfoDic?["StoreSection"], namefield: "StoreSection",isEnable:true),RequstPersonInfoModel(nameStr: "员工人数", placeHodlerStr: customerInfoDic?["Staff"], namefield: "Staff",isEnable:true),RequstPersonInfoModel(nameStr: "门店物业性质", placeHodlerStr: customerInfoDic?["PropertyNature"], namefield: "PropertyNature",isEnable:true),RequstPersonInfoModel(nameStr: "每月租金", placeHodlerStr: customerInfoDic?["Monthly"], namefield: "Monthly",isEnable:true),RequstPersonInfoModel(nameStr: "付租方式", placeHodlerStr: customerInfoDic?["PayMedthod"], namefield: "PayMedthod",isEnable:true),RequstPersonInfoModel(nameStr: "房屋租赁起始时间", placeHodlerStr: customerInfoDic?["RentStartTime"] == nil ? "点击选择时间" : customerInfoDic?["RentStartTime"], namefield: "RentStartTime",isEnable:true),RequstPersonInfoModel(nameStr: "房屋租赁结束时间", placeHodlerStr: customerInfoDic?["RentEndTime"]  == nil ? "点击选择时间" : customerInfoDic?["RentEndTime"], namefield: "RentEndTime",isEnable:true),RequstPersonInfoModel(nameStr: "房东姓名", placeHodlerStr: customerInfoDic?["LandlordNmae"], namefield: "LandlordNmae",isEnable:true),RequstPersonInfoModel(nameStr: "房东联系方式", placeHodlerStr: customerInfoDic?["LandlordPhone"], namefield: "LandlordPhone",isEnable:true)]
        
        
        selectedArr = [["1-3","3-5","5-10","大于10"],["50平","50-100平","100-200平","200平以上"],["商圈","医院周围","学校周围","办公区周围","其他"],["5人以内","5人-10人","10人-30人","30人以上"],["租赁","自有有按揭","自有无按揭","其他"],["1万以内","1万-2万","2万-5万","5万以上"],["每3个月缴纳一次","每6个月一次","每年缴纳一次","其他"]]
        
        dropaArr = [DropDown(),DropDown(),DropDown(),DropDown(),DropDown(),DropDown(),DropDown()]
        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func changeTypeAction(_ sender: UIButton) {
        
        switch sender.tag - 666 {
        case 6...12:
            
            let drop = dropaArr[sender.tag - 666 - 6]
            drop.show()
            
            return
        default:
            break
        }
        
        //        UIView.animate(withDuration: 0.5, animations: {
        //
        //            sender.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
        //
        //        }
        dropDown1.show()
        
    }

    
    func sucessBtnAction() {
        
        if customerInfoDic?["StoreType"] == "无" {
            customerInfoDic?.removeAll()
            customerInfoDic?["StoreType"] = "无"
            UserDefaults.standard.setValue(customerInfoDic, forKey: "ShopTypeKey")
            UserDefaults.standard.synchronize()
            self.noticeOnlyText("已保存")
            self.perform(#selector(ShopTypeVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            if let block1 = block {
                block1(true)
            }
            return
        }
        
        UserDefaults.standard.setValue(customerInfoDic, forKey: "ShopTypeKey")
        UserDefaults.standard.synchronize()
        guard (customerInfoDic?.count)! >= 17 else {
            
            self.noticeOnlyText("已保存,但信息内容不全")
            
            self.perform(#selector(ShopTypeVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
            if let block1 = block {
                block1(false)
                
            }
            
            return
        }
        
        self.noticeOnlyText("已保存")
        self.perform(#selector(ShopTypeVc.popVc), with: nil, afterDelay: 0.5, inModes: [RunLoopMode.commonModes])
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
        
        let  btn = UIButton.init(CGRect(x: (Screen_Width - 211)/2, y: 50, width: 211, height: 48), imageName: nil, title: "保存", target: self, action: #selector(ShopTypeVc.sucessBtnAction))
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

extension ShopTypeVc: UITableViewDelegate,UITableViewDataSource,FillCustomerCellDelagete {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 45)
//        view.backgroundColor = UIColor.white
//        let lb = UILabel()
//        lb.frame = CGRect(x: 20, y: 15, width: Screen_Width, height: 20)
//        lb.text = "非同住亲友信息"
//        lb.font = UIFont.systemFont(ofSize: 14)
//        view.addSubview(lb)
//        
//        return view
//        
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return 40
//        
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isBool {
            return dataArr.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataArr[indexPath.row] as RequstPersonInfoModel

        if  indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
            cell.selectionStyle = .none
            var model = dataArr[indexPath.row]
            cell.reloadRequestUI(model)
            cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
            
//            let realm = try! Realm()
//            
//            let requstModel = realm.object(ofType: RequestRealm.self, forPrimaryKey: "requestRealmID")
            
            cell.textField.text = model.placeHodlerStr
            customerInfoDic?["StoreType"] = model.placeHodlerStr
            dropDown1.anchorView = cell
            dropDown1.direction = .any
            dropDown1.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
            dropDown1.backgroundColor = UIColor.white
            dropDown1.dataSource = ["无", "临街店铺","写字楼","仓库","其他"]
            dropDown1.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
            //            dropDown1.cancelAction = { () -> Void in
            //
            //                UIView.animate(withDuration: 0.5, animations: {
            //
            //                    cell.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
            //
            //                })
            //            }
            dropDown1.selectionAction = {[weak self] (index: Int, item: String) in
                //                UIView.animate(withDuration: 0.5, animations: {
                //
                //                    cell.changeType.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi * 2))
                //
                //
                //                })
                
                self?.isBool = item != "无"
                
                cell.textField.text = item
                model.placeHodlerStr = item
                self?.dataArr[0] = model
                self?.tableView.reloadData()
                self?.customerInfoDic?["StoreType"] = item
            }
            
            return cell
            
        }
        
        switch indexPath.row {
        case 6...12:
            
            let cell = createCell(indexPath.row)
            
            return cell
            
        default:
            break
        }
        

        
        if indexPath.row == 5 || indexPath.row == 14 || indexPath.row == 13{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TimeCell.self)) as! TimeCell
            cell.selectionStyle = .none
            cell.reloadUI(model)
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FillCustomerCellID") as! FillCustomerCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        cell.reloadRequestUI(model,row:indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 5 || indexPath.row == 14 || indexPath.row == 13 {
            
//            let pickerView = UIDatePicker()
//            pickerView.frame = CGRect(x: 0, y: Screen_Height - 200, width: Screen_Width,height: 200)
//            pickerView.locale = Locale.init(identifier: "zh")
//            pickerView.datePickerMode = .date
//            pickerView.backgroundColor = UIColor.white
//            Print(pickerView.date.gy_stringFromDate(dateFormat: "yyyy-MM-dd"))
            currentimePicker = indexPath.row
            pickerView = UINib.init(nibName: "GYDatePicker", bundle: nil).instantiate(withOwner: nil, options: nil).last as! GYDatePicker
            
            pickerView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64)
            pickerView.sureBtn.addTarget(self, action: #selector(ShopTypeVc.timeAction), for: UIControlEvents.touchUpInside)
            view.addSubview(pickerView)
            
            
        }
        
    }
    
    func createCell(_ indexRow: Int) -> FillBootomView {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FillBootomViewID") as! FillBootomView
        cell.selectionStyle = .none
        var model = dataArr[indexRow]
        let selecteModel = selectedArr[indexRow - 6]
        let drop = dropaArr[indexRow - 6]
        cell.reloadRequestUI(model)
        cell.changeType.tag = 666 + indexRow
        cell.changeType.addTarget(self, action: #selector(changeTypeAction(_:)), for: UIControlEvents.touchUpInside)
        
        if model.placeHodlerStr == nil {
            model.placeHodlerStr = selecteModel[0]
        }
        
        cell.textField.text = model.placeHodlerStr == "" ? selecteModel[0] : model.placeHodlerStr
        customerInfoDic?["BusinessNature"] = cell.textField.text
        drop.anchorView = cell
        drop.direction = .any
        drop.bottomOffset = CGPoint(x: 0, y:cell.bounds.height)
        drop.backgroundColor = UIColor.white
        drop.dataSource = selecteModel
        drop.cellNib = UINib(nibName: "DropMyCell", bundle: nil)
        
        drop.selectionAction = {[weak self] (index: Int, item: String) in
            
            cell.textField.text = item
            model.placeHodlerStr = item
            self?.dataArr[indexRow] = model
            self?.tableView.reloadData()
            
            switch indexRow {
            case 6:
                self?.customerInfoDic?["StoreCount"] = item
                break
            case 7:
                self?.customerInfoDic?["BusinessArea"] = item

                break
            case 8:
                self?.customerInfoDic?["StoreSection"] = item

                break
            case 9:
                self?.customerInfoDic?["Staff"] = item

                break
            case 10:
                self?.customerInfoDic?["PropertyNature"] = item

                break
            case 11:
                self?.customerInfoDic?["Monthly"] = item

                break
            case 12:
                self?.customerInfoDic?["PayMedthod"] = item

                break
            default:
                break
            }
            
            //                self?.currentLevel = item
            //                self?.customerInfoDic?["applicantlevel"] = item
        }
        return cell
        
    }
    
    func timeAction() {
        
        var model = dataArr[currentimePicker]
        model.placeHodlerStr = pickerView.dataPicker.date.gy_stringFromDate(dateFormat: "yyyy-MM-dd")
        
        dataArr[currentimePicker] = model
        
        switch currentimePicker {
        case 5:
            customerInfoDic?["OpeningTime"] = model.placeHodlerStr
            
            break
        case 13:
            customerInfoDic?["RentStartTime"] = model.placeHodlerStr

            break
        case 14:
            customerInfoDic?["RentEndTime"] = model.placeHodlerStr

            break
        default:
            break
        }
        
        tableView.reloadData()
        pickerView.removeFromSuperview()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
        
    }
    
    
}
