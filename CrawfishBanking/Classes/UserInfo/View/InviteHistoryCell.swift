//
//  InviteHistoryCell.swift
//  
//
//  Created by ZGY on 2017/6/27.
//
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/27  下午1:37
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class InviteHistoryCell: UITableViewCell {

    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var stateLb: UILabel!
    @IBOutlet weak var moneyLb: UILabel!
    @IBOutlet weak var typeLb: UILabel!
    @IBOutlet weak var phoneLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
    }

    func reloadUI(_ model:InviteInfoModel) {
        
        nameLb.text = model.ApplyUserName
        phoneLb.text = model.ApplyUserPhone
        typeLb.text = model.Product
        moneyLb.text = "¥ " + Tools.formatNumberToMoney(Double(model.Funding) ?? 0.00)
        
        var stateStr = ""
        switch model.CheckState {
        case 0:
            stateStr = "正在审核"
            break
//        case 1:
//            break
//        case 2:
//            break
        default:stateStr = "正在审核"
            break
        }
        
        stateLb.text = stateStr
        
        
        
        timeLb.text = Tools.dateFromServiceTimeStamp(model.CreateTime)?.gy_stringFromDate(dateFormat: "yyyy-MM-dd")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
