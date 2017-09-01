//
//  ConfirmViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/2.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/2  上午11:06
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import SnapKit

class ConfirmViewController: GYBaseViewController {
    
    //MARK: - Attributes
    var stateView: StateView!
    
    var loadingView: GYIndicatorView?
    
    var confirmBtnView: ConfirmBtnView!

    override func viewDidLoad() {
        super.viewDidLoad()

        stateView = UINib(nibName: "StateView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! StateView
        stateView.frame = CGRect(x: 0, y: 64, width: Screen_Width, height: 229)
        view.addSubview(stateView)
        
        confirmBtnView = ConfirmBtnView(frame: CGRect(x: 0, y: 350, width: Screen_Width, height: 40))
        view.addSubview(confirmBtnView)
        confirmBtnView.delegate = self
//        confirmBtnView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        loadingView = GYIndicatorView.init(CGRect(x: 0, y: 0, width: 60, height: 60), tintColor: UIColor.black)
        view.addSubview(loadingView!)
        loadingView?.snp.makeConstraints({ (make) in
            make.top.equalTo(stateView.moneyNumLb.snp.top).offset(40)
            make.leading.equalTo(view).offset((Screen_Width - 60)/2)
        })
        
        loadingView?.startAnimating()

        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    deinit {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ConfirmViewController: ConfirmBtnViewDelegate {
    
    func selectedBtn(_ tag: Int) {
        
        switch tag {
        case 666:
            
            self.present(GYNavigationController(rootViewController: FillCustomerViewController()), animated: false, completion: nil)
            break
        case 777:
             self.present(GYNavigationController(rootViewController: FinancingViewController()), animated: false, completion: nil)
//            self.present(GYNavigationController(rootViewController: RequestVc()), animated: false, completion: nil)
            break
        default:
            break
        }
        
    }
    
}
