//
//  FinancingViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/2.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/2  下午3:03
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class FinancingViewController: GYBaseBackViewController {
    
    //MARK: - Attributes
    
//    var letfList: LeftListViewController!
    var topView: ApplicationTopView!
    var rightView: UIView!
    var pushType:Bool = true
    var requestId:String?
    var state: LoadRequestStruct!
    var isRequest:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的申请"

        automaticallyAdjustsScrollViewInsets = true
        self.edgesForExtendedLayout = UIRectEdge.all

        GYNetWorking.default.requestJson(GYRouter.getUserApplyStateByID(parameters:["ID":requestId ?? ""]), sucess: { [weak self](data) in
            Print(data)
            
            let json = data as? [String:AnyObject]
            let stateCode = json?["status"] as? Int
            let stateStr = json?["msg"] as? String ?? ""

            self?.initUI(stateCode ?? 4,str:stateStr)
            
        }) { (error) in
            Print(error)
        }
    
        
     
        
//        let request1 = LoansVc()
//        addChildViewController(request1)
//        rightView.addSubview(request1.view)
        
//        rightView.bringSubview(toFront: request.view)
    }
    
    //MARK: - Override
    
    override func backAction() {
        if pushType {
            navigationController?.popViewController(animated: true)
            return
        }
        self.dismiss(animated: false, completion: nil)
        appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())

    }
    //MARK: - Initial Methods
    
    
    fileprivate func initUI(_ stateCode:Int,str:String) {
        
        switch stateCode {
        case 1,5:
            //审核通过
            state = LoadRequestStruct(LoadRequestStruct.RequestState.checking, checkState: LoadRequestStruct.CheckState.checking, contractState: LoadRequestStruct.ContractState.success, loansState: LoadRequestStruct.LoansState.unKown, repaymentState: LoadRequestStruct.RepaymentState.unKown)
            break
        case 2:
            //正在审核
            state = LoadRequestStruct(LoadRequestStruct.RequestState.checking, checkState: LoadRequestStruct.CheckState.success, contractState: LoadRequestStruct.ContractState.unKown, loansState: LoadRequestStruct.LoansState.unKown, repaymentState: LoadRequestStruct.RepaymentState.unKown)
            break
        case 3:
            //已被拒绝
            state = LoadRequestStruct(LoadRequestStruct.RequestState.checking, checkState: LoadRequestStruct.CheckState.success, contractState: LoadRequestStruct.ContractState.unKown, loansState: LoadRequestStruct.LoansState.unKown, repaymentState: LoadRequestStruct.RepaymentState.unKown)
            break
        case 4:
            // 未填写申请表"
            state = LoadRequestStruct(LoadRequestStruct.RequestState.success, checkState: LoadRequestStruct.CheckState.unKown, contractState: LoadRequestStruct.ContractState.unKown, loansState: LoadRequestStruct.LoansState.unKown, repaymentState: LoadRequestStruct.RepaymentState.unKown)

            break
        default:
            state = LoadRequestStruct(LoadRequestStruct.RequestState.checking, checkState: LoadRequestStruct.CheckState.checking, contractState: LoadRequestStruct.ContractState.success, loansState: LoadRequestStruct.LoansState.unKown, repaymentState: LoadRequestStruct.RepaymentState.unKown)
            break
        }
        topView = UINib.init(nibName: "ApplicationTopView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! ApplicationTopView
        //自动减去64
        topView.frame = CGRect(x: 0, y: 15, width: Screen_Width, height: 120)
        topView.delegate = self
        topView.instanceUI(state)
        view.addSubview(topView)
        
        rightView = UIView(frame: CGRect(x: 0, y: 66, width: Screen_Width, height: Screen_Height - 136))
        view.addSubview(rightView)
        isRequest = true
        
        switch stateCode {
        case 1,5:
            
            let request = ContractVc()
            request.urlStr = requestId
            addChildViewController(request)
            rightView.addSubview(request.view)

            break
        case 2:
            let request = ReviewVc()
            request.state = str
            addChildViewController(request)
            rightView.addSubview(request.view)
            break
        case 3:
            let request = ReviewVc()
            request.state = str
            addChildViewController(request)
            rightView.addSubview(request.view)
            break
        case 4:
            let request = RequestVc()
            request.view.frame = rightView.bounds
            addChildViewController(request)
            rightView.addSubview(request.view)
            break
        default:
            let request = ContractVc()
            request.urlStr = requestId
            addChildViewController(request)
            rightView.addSubview(request.view)
            break
        }
        

        
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

extension FinancingViewController: ApplicationTopViewDelegate {
    
    func sendTagToright(_ tag: Int) {
//        return
        if rightView.subviews.count > 0 {
            rightView.subviews[0].removeFromSuperview()
            Print(childViewControllers.count)
            childViewControllers[0].removeFromParentViewController()
        }
        switch tag {
        case 555:
            let request = RequestVc()
            addChildViewController(request)
            rightView.addSubview(request.view)
            break
        case 666:
            let request = ReviewVc()
            addChildViewController(request)
            rightView.addSubview(request.view)
         
            break
        case 777:
   
            let request = ContractVc()
            request.urlStr = requestId
            addChildViewController(request)
            rightView.addSubview(request.view)
            
            break
        case 888:

            let request = LoansVc()
            addChildViewController(request)
            rightView.addSubview(request.view)
            
            break
        case 999:
//            let request = RepaymentVc()
//            addChildViewController(request)
//            rightView.addSubview(request.view)
            break
        
        default:
            break
        }
        
    }
    
}
