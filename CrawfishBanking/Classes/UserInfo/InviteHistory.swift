//
//  InviteHistory.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/27.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/27  下午1:35
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import ObjectMapper

class InviteHistory: GYBaseBackViewController {
    
    //MARK: - Attributes

    var tableView: UITableView!
    var numbers:String = "0"
    
    var dataArr:[InviteInfoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "邀请记录"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64))
        tableView.backgroundColor = tableViewBgC
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "InviteHistoryCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(InviteHistoryCell.self))
    
        
        GYNetWorking.default.requestJson(GYRouter.getInviterInfo(parameters: [:]), sucess: { [weak self](data) in
            
            let json = data["data"] as? [[String:AnyObject]]
            self?.numbers = data["msg"] as? String ?? "0"
            for item in json! {
                
                let tmp = Mapper<InviteInfoModel>().map(JSON: item)
                self?.dataArr.append(tmp!)
            }
            
            self?.tableView.reloadData()
            Print(json)
            
        }) { (error) in
            Print(error)
        }
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    
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

extension InviteHistory: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: Screen_Width , height: 60)
        view1.backgroundColor = tableViewBgC
        
        let view2 = UIView()
        view2.frame = CGRect(x: 20, y: 12, width: Screen_Width - 40, height: 48)
        view2.backgroundColor = UIColor.white
        view2.layer.cornerRadius = 5
        view2.layer.masksToBounds = true
        view1.addSubview(view2)
        let lb = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 21))
        lb.text = "邀请人数"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = UIColor.init(hexColor: "999999")
        view2.addSubview(lb)
        
        let lb2 = UILabel(frame: CGRect(x: 130, y: 15, width: view2.gy_width - 130 - 15, height: 21))
        lb2.text = numbers
        lb2.font = UIFont.systemFont(ofSize: 18)
        lb2.textAlignment = .right
        lb2.textColor = UIColor.init(hexColor: "333333")
        view2.addSubview(lb2)
        
        return view1
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(InviteHistoryCell.self)) as! InviteHistoryCell
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row]
        
        cell.reloadUI(model)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
