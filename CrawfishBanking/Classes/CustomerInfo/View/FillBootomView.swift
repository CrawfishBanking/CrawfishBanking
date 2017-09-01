//
//  FillHeadView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/27.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/27  下午2:15
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class FillBootomView: UITableViewCell {


    @IBOutlet weak var changeType: UIButton!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reloadUI(_ model: FillCustomerModel) {
        
        textField.text = model.placeHodlerStr
//        textField.textColor = UIColor.init(hexColor: "")
    }
    
    func reloadRequestUI(_ model: RequstPersonInfoModel) {
        titleLb.text = model.nameStr

        if model.namefield == "666666" {
            titleLb.font = UIFont.systemFont(ofSize: 15)
            titleLb.textColor = UIColor.black
            lineView.isHidden = true
        } else {
            titleLb.font = UIFont.systemFont(ofSize: 13)
            titleLb.textColor = UIColor.init(hexColor: "999999")
            lineView.isHidden = false
        }
        textField.text = model.placeHodlerStr
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.adjustsFontSizeToFitWidth = true
    
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
