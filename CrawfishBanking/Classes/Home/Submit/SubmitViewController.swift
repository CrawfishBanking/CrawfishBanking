//
//  SubmitViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午1:14
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift
import ObjectMapper
class SubmitViewController: GYBaseBackViewController {
    
    //MARK: - Attributes

    var tableView: UITableView!
    var dataArr:[HistoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func reloadDataA() {
        
        GYNetWorking.default.requestJson(GYRouter.getUserApplyHistory(parameters: [:]), sucess: { (data) in
            Print(data)
            let json = data["data"] as? [[String:AnyObject]]
            self.dataArr.removeAll()

            if json == nil || json?.count == 0 {
                
                self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "申请记录无"))
                return
            } else {
               self.tableView.backgroundView = nil
            }
            
            for item in json! {
                let tmp = Mapper<HistoryModel>().map(JSON: item)
                
                self.dataArr.append(tmp!)
            }
            self.tableView.reloadData()
            Print(self.dataArr)
            
        }) { (error) in
            Print(error)
        }
        
    }
    
    fileprivate func initUI() {
        
        title = "融资申请"
        navigationItem.rightBarButtonItem =  UIBarButtonItem.init(customView: rightBtn)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64), style: UITableViewStyle.plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(HistoryCell.self))
        
    }
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func rightAction() {
        
        loadUserInfo()
     
    }
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    fileprivate func loadUserInfo() {
        
        let vc = ProductTypeVc.init(true)
        vc.isRevise = true
        UserDefaults.standard.set(1, forKey: "isPushSubMit")
        UserDefaults.standard.synchronize()
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
    //MARK: - Setter Getter Methods
    
    private lazy var rightBtn: UIButton = {
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(SubmitViewController.rightAction), for: UIControlEvents.touchUpInside)
//        btn.setImage(#imageLiteral(resourceName: "RightAddBtn"), for: UIControlState.normal)
        btn.setTitle("填写申请", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.titleLabel?.textAlignment = .right
//        btn.backgroundColor = UIColor.black
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.frame = CGRect(x: 10, y: 10, width: 70, height: 40)
        return btn
        
    }()
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataA()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.clearAllNotice()
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

extension SubmitViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        loadUserInfo()
        let model = dataArr[indexPath.row]
        let vc = FinancingViewController()
        vc.requestId = String(model.ID)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HistoryCell.self)) as! HistoryCell
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row]
        
        cell.reloadUI(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 208
    }
    
}
