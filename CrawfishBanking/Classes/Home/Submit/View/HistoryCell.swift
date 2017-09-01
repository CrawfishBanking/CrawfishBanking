//
//  HistoryCell.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/5.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/5  下午5:35
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var timeLimitLb: UILabel!
    @IBOutlet weak var stateLb: UILabel!
    @IBOutlet weak var limitLb: UILabel!
    @IBOutlet weak var typeLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadUI(_ model: HistoryModel) {
        
        timeLb.text = Tools.dateFromServiceTimeStamp(model.ApplyTime)?.gy_stringFromDate(dateFormat: "yyyy-MM-dd hh:mm:ss")
        typeLb.text = model.Product
        limitLb.text =  "¥ " + Tools.formatNumberToMoney(Double( model.Funding) ?? 0.00)
        stateLb.text = model.flowmsg
        timeLimitLb.text =  "更新于" + (Tools.dateFromServiceTimeStamp(model.UpdateTime)?.descDate ?? "未知时间")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
