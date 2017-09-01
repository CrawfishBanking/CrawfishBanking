//
//  RequestMainCell.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/8.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/8  下午4:58
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class RequestMainCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var state: UILabel!
    func reloadRequestUI(_ model:RequestModel) {
        
        personImage.image = UIImage(named: model.titleName!)
        if model.state == "0" {
            state.text = "待完成"
        } else {
            state.text = "已完成"
        }
        
        titleLb.text = model.titleName
         
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
