//
//  TimeCell.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/14.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/14  下午4:10
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class TimeCell: UITableViewCell {

    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadUI(_ model: RequstPersonInfoModel) {
        
        titleLb.text = model.nameStr
        timeLb.text = model.placeHodlerStr
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
