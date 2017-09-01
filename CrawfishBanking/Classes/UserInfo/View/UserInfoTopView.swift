//
//  UserInfoTopView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/18.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/18  上午9:31
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class UserInfoTopView: UIView {
    
    @IBOutlet weak var oznertypeLb: UILabel!
    @IBOutlet weak var phoneLb: UIButton!
    @IBOutlet weak var typeLb: UILabel!
    @IBOutlet weak var quotaLb: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(hexColor: "EBE9F0")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
