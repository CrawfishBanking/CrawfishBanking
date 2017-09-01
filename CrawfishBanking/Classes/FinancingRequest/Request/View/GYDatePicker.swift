//
//  GYDatePicker.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/14.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/14  下午5:19
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYDatePicker: UIView {

    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var cancle: UIButton!
    @IBAction func cancleAction(_ sender: UIButton) {
        self.removeFromSuperview()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.black
//        self.alpha = 0.5
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
        
    }

}
