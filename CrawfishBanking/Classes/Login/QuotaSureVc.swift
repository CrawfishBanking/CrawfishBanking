//
//  QuotaSureVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/15.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/15  下午5:18
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class QuotaSureVc: GYBaseBackViewController {
    
    @IBOutlet weak var typeLb: UILabel!
    @IBOutlet weak var numLb: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var loadMesg:(typeStr: String,numStr: String)?
    var isRevese:Bool = false
    
    //MARK: - Attributes
    @IBOutlet weak var centerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "融资额度"

        let tagIndex = UserDefaults.standard.value(forKey: "isPushSubMit") as? Int ?? 0

        if isRevese && tagIndex != 1 {
            
            btn1.setTitle("返回", for: UIControlState.normal)
            btn2.isHidden = true
        }
        
        
        if tagIndex == 1 {
            btn1.setTitle("申请融资", for: UIControlState.normal)
            btn2.isHidden = true
        }
        
        centerView.layer.cornerRadius = (Screen_Width - 140) / 2.0
        centerView.layer.masksToBounds = true
        centerView.layer.borderColor = UIColor.init(hexColor: "f89e5b").cgColor
        centerView.layer.borderWidth = 3.0
        
        typeLb.text = loadMesg?.typeStr
        
        var moneyStr = loadMesg?.numStr
        if loadMesg?.numStr != "未知" && (loadMesg?.numStr.checkifNotNull())!{
            moneyStr = "¥ " + Tools.formatNumberToMoney(Double((loadMesg?.numStr)!)!)
        }
        
        numLb.text = moneyStr
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    @IBAction func ApplicationAction(_ sender: UIButton) {
        
        if btn2.isHidden && btn1.currentTitle != "申请融资"{
            navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
            return
        }
        
        if btn2.isHidden && btn1.currentTitle == "申请融资" {
            UserDefaults.standard.set(0, forKey: "isPushSubMit")
            UserDefaults.standard.synchronize()
            let vc = RequestVc()
            vc.type = false
            
//            navigationController?.pushViewController(vc, animated: true)
            self.present(GYNavigationController(rootViewController: vc), animated: false, completion: nil)
            return
        }
        
//        let vc = FinancingViewController()
//        vc.pushType = false
//        
//        self.present(GYNavigationController(rootViewController: vc), animated: false, completion: nil)
        let vc = RequestVc()
        vc.type = false
       
        self.present(GYNavigationController(rootViewController: vc), animated: false, completion: nil)
    }
    
    @IBAction func ReappearAction(_ sender: UIButton) {
        
         self.present(GYNavigationController(rootViewController: ProductTypeVc.init(false)), animated: false, completion: nil)
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
