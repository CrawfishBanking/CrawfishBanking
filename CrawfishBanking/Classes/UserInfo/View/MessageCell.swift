//
//  MessageCell.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/5.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/5  上午11:21
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit
import SnapKit

class MessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
        
    }
    
    fileprivate func initUI() {
        
        contentView.addSubview(titleLb)
        contentView.addSubview(timeLb)
        
        titleLb.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
//            make.width.equalTo(Screen_Width - 30)
            make.height.greaterThanOrEqualTo(20)

        }
        
        timeLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(Screen_Width - 30)
        }
        
    }
    
    private lazy var titleLb: UILabel = {
       
        let lb = UILabel()
        lb.frame = CGRect.zero
        lb.textColor = UIColor.init(hexColor: "333333")
        lb.numberOfLines  = 2
        lb.text = "daudha你是耽误你等我未安徽嗲话带1audha你是耽误你等我未安徽嗲话带1a"
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
        
    }()
    
    private lazy var timeLb: UILabel = {
        
        let lb = UILabel()
        lb.textColor = UIColor.init(hexColor: "333333")
        lb.text = "16:11:20102"
        lb.frame = CGRect.zero
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
