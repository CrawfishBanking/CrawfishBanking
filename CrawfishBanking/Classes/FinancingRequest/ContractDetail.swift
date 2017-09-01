//
//  ContractDetail.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/29.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/29  上午9:42
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class ContractDetail: GYBaseBackViewController {
    
    //MARK: - Attributes

    var urlStr:String?
    
    var titleStr:String?
    
    var isBool:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleStr
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 125))
    
//        Print( GYServiceApi.CompactInfo() + "?usertoken=" + (UserAccount.loadAccount()?.acctoken)! ?? "")
        webView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - 64)
        
        view.addSubview(webView)
        webView.scalesPageToFit = true
        webView.loadRequest(URLRequest(url: URL(string:urlStr!)!))
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
    
    override func backAction() {
        
        if isBool {
            navigationController?.popViewController(animated: true)
            return
        }
        
        self.dismiss(animated: true, completion: nil)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
