//
//  GYBaseBackViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/25.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/25  下午1:19
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit


class GYBaseBackViewController: GYBaseViewController {
    
    //MARK: - Attributes

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUI()
     
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func addUI() {
        
        view.backgroundColor = UIColor.white
        let backBtn = UIButton()
        
        backBtn.setImage(UIImage(named: "backBg"), for: UIControlState.normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        backBtn.addTarget(self, action: #selector(GYBaseBackViewController.backAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
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
