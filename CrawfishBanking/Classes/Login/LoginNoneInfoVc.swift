//
//  LoginNoneInfoVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/26.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/26  下午2:57
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import SnapKit

class LoginNoneInfoVc: GYBaseViewController {
    
    //MARK: - Attributes

    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var centerView: UIView!
    
    var currentBtn: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    
    @IBAction func leftBtnAction(_ sender: Any) {
        
        guard currentBtn > -1 else {
            return
        }
        currentBtn -= 1
        switch currentBtn {
        case 0:
            leftBtn.isHidden = true
            removeView()
        case 1:
            addStateView()
        case 2,3:
            rightBtn.isHidden = false
            changeStateView2()
        case 4:
            rightBtn.isHidden = true
            changeStateView2()
        default:
            break
        }
        
    }
    
    @IBAction func rightBtn(_ sender: UIButton) {
        guard currentBtn < 5 else {
            return
        }
        currentBtn += 1
        switch currentBtn {
        case 0:
            leftBtn.isHidden = true
            break
        case 1:
            leftBtn.isHidden = false
            addStateView()
        case 2:
            addStateView2()
            changeStateView2()
        case 3:
            rightBtn.isHidden = false
            changeStateView2()
        case 4:
            rightBtn.isHidden = true
            changeStateView2()
        default:
            break
        }
        
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        
        appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sureAction(_ sender: Any) {
        
        switch currentBtn {
        case 0:
 
//            let vc = ProductTypeVc.init(false)
            
            self.present(GYNavigationController(rootViewController: ProductTypeVc.init(false)), animated: false, completion: nil)
            break
        case 1:break
        case 2:break
        case 3:break
        case 4:break
        default:
            break
        }
        
    }
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    fileprivate func removeView() {
        
        (centerView.subviews as NSArray).enumerateObjects({ (subView, idx, stop) in
            let sub = subView as! UIView
            
            if sub.isKind(of:StateView.self) {
                sub.removeFromSuperview()
            }
            
        })
        
    }
    
    fileprivate func addStateView() {
        
        (centerView.subviews as NSArray).enumerateObjects({ (subView, idx, stop) in
            let sub = subView as! UIView
            
            if sub.isKind(of: StateSecondView.self) {
                sub.removeFromSuperview()
            }
            
            if sub.isKind(of:StateView.self) {
                return
            }
            
        })
        
        let stateView = UINib(nibName: "StateView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! StateView
        
        centerView.addSubview(stateView)
        
        stateView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalTo(0)
            
        }
    }
    
    fileprivate func addStateView2() {
        
        let stateView = UINib(nibName: "StateSecondView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! StateSecondView
        stateView.tag = 666
        centerView.addSubview(stateView)
        
        stateView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalTo(0)
            
        }
    }
    
    fileprivate func changeStateView2() {
        
        let view = centerView.viewWithTag(666) as! StateSecondView
        
        switch currentBtn {
        case 2:
            view.stateLb.text = "您有一笔贷款正在审核中,是否查看?"
            break
        case 3:
            view.stateLb.text = "您的贷款已经审核成功,立刻查看?"
            break
        case 4:
            view.stateLb.text = "您的还款信息已成功,是否查看?"
            break
        default:
            break
        }
        
    }
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
      Print(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
