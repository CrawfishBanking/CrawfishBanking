//
//  GYReminderView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/19.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/19  下午5:32
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYReminderView: UIView {

    @IBOutlet weak var lb1: UILabel!
    
    @IBOutlet weak var iKnownBtn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let text = NSMutableAttributedString.init(string: "该业务请联系小龙虾业务部")
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6

        let dic = [NSFontAttributeName:  UIFont.boldSystemFont(ofSize: 21),NSForegroundColorAttributeName: UIColor.init(hexColor: "333333"),NSParagraphStyleAttributeName:style]
        
        text.addAttributes(dic, range: NSRange(location: 0, length: text.length))
        
        lb1.attributedText = text
//        btn1.titleLabel?.attributedText = text
//        btn1.currentAttributedTitle = text
        
        let text1 = NSMutableAttributedString.init(string: "电话: 400-9612628")
        text1.addAttributes(dic, range: NSRange(location: 0, length: text1.length))
        btn1.setAttributedTitle(text1, for: UIControlState.normal)
        
        let text2 = NSMutableAttributedString.init(string: "邮箱: xlx@cftcn.com")
        text2.addAttributes(dic, range: NSRange(location: 0, length: text2.length))
        btn2.setAttributedTitle(text2, for: UIControlState.normal)
        
        iKnownBtn.layer.masksToBounds = true
        iKnownBtn.layer.cornerRadius = 23
        
        
        
    }
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if sender.tag == 666 {
            
            UIApplication.shared.openURL(URL(string: "tel://4009612628")!)
            
            return
        }
        
//        let vc = GMailVc()
//        appDelegate.window?.currentViewController?.present(vc, animated: true, completion: nil)
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
