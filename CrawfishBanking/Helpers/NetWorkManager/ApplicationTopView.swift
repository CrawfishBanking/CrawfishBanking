//
//  ApplicationTopView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/17.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/17  上午10:33
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

@objc protocol ApplicationTopViewDelegate {
    
    func sendTagToright(_ tag: Int)
    
}

class ApplicationTopView: UIView {
    
    weak var delegate:ApplicationTopViewDelegate?

    var state: LoadRequestStruct!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var currentBtn:UIButton?
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        guard currentBtn != sender else {
            return
        }
        
        switch sender.tag {
        case 555:
            guard (state.requestState == LoadRequestStruct.RequestState.success) else {
                return
            }
            
        case 666:
            guard (state.checkState == LoadRequestStruct.CheckState.success) else {
                return
            }
        case 777:
            guard (state.contractState == LoadRequestStruct.ContractState.success) else {
                return
            }
        case 888:
            guard (state.loansState == LoadRequestStruct.LoansState.success) else {
                return
            }

        case 999:
            guard (state.repaymentState == LoadRequestStruct.RepaymentState.success) else {
                return
            }
        default:
            break
        }
        
        changState(sender)
        delegate?.sendTagToright(sender.tag)
    }
    
    func changState(_ sender: UIButton) {
        
        sender.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
        currentBtn?.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
        currentBtn = sender
        
    }
    
    func instanceUI(_ state: LoadRequestStruct) {
        self.state = state
        switch state.requestState! {
        case .unKown:
            btn1.setImage(#imageLiteral(resourceName: "未进行"), for: UIControlState.normal)
            break
        case .checking:
            btn1.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
            break
        case .success:
            btn1.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
            currentBtn = btn1
            break
        }
        
        switch state.checkState! {
        case .unKown:
            btn2.setImage(#imageLiteral(resourceName: "未进行"), for: UIControlState.normal)
            break
        case .checking:
            btn2.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
            break
        case .success:
            btn2.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
            currentBtn = btn2
            break
        }
        
        switch state.contractState! {
        case .unKown:
            btn3.setImage(#imageLiteral(resourceName: "未进行"), for: UIControlState.normal)
            break
        case .checking:
            btn3.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
            break
        case .success:
            btn3.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
            currentBtn = btn3
            break
        }
        
        
        switch state.loansState! {
        case .unKown:
            btn4.setImage(#imageLiteral(resourceName: "未进行"), for: UIControlState.normal)
            break
        case .checking:
            btn4.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
            break
        case .success:
            btn4.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
            currentBtn = btn4
            break
        }
        
        
        switch state.repaymentState! {
        case .unKown:
            btn5.setImage(#imageLiteral(resourceName: "未进行"), for: UIControlState.normal)
            break
        case .checking:
            btn5.setImage(#imageLiteral(resourceName: "进行中"), for: UIControlState.normal)
            break
        case .success:
            btn5.setImage(#imageLiteral(resourceName: "已完成"), for: UIControlState.normal)
            currentBtn = btn5
            break
        }
        
        
    }
}
