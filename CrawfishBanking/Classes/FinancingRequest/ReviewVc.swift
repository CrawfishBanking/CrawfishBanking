//
//  ReviewVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/3.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/3  下午2:49
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class ReviewVc: GYBaseViewController {
    
    //MARK: - Attributes
    
    var state:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "申请中"))
        imageView.frame = CGRect(x: 40, y: 30, width: Screen_Width - 80, height: Screen_Width - 80)
        view.addSubview(imageView)
        
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = UIColor.init(hexColor: "333333")
        lb.textAlignment = .center
        lb.frame = CGRect(x: 60, y: imageView.gy_bootom + 40, width: Screen_Width - 120, height: 150)
        lb.text = state ?? "您的申请正在审核中\n请耐心等待"
        view.addSubview(lb)

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
    
    private lazy var lb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = UIColor.blue
        lb.frame = CGRect(x: 60, y: 0, width: Screen_Width, height: 200)
        lb.text = "您的申请正在审核中,请耐心等待!"
        return lb
    }()
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
