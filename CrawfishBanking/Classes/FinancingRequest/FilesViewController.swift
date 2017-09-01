//
//  FilesViewController.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/4.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/4  下午5:08
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class FilesViewController: GYBaseViewController {
    
    //MARK: - Attributes
    var titleView: GYPageTitleView!
    var pageContentView: GYPageContainerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        let titles = ["项目信息","合同信息","还款计划"]
        titleView = GYPageTitleView.init(CGRect(x: 0, y: 64, width: Screen_Width, height: 60), titles: titles)
        titleView.delegate = self
        view.addSubview(titleView)
        
        let childVcs = [RequestVc(),ReviewVc(),ContractVc()]
        let contentViewFrame = CGRect(x: 0, y: 60 + 64, width: Screen_Width, height: Screen_Height)
        
        pageContentView = GYPageContainerView(contentViewFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        view.addSubview(pageContentView)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilesViewController: GYPageTitleViewDelegate ,GYPageContainerViewDelegate{
    
    func pageContainerView(_ progress: CGFloat, before: NSInteger, current: NSInteger) {
        
        titleView.setTitleChange(progress, before: before, currentIndex: current)
    }
    
    func pageCurrentTitle(_ index: NSInteger) {
        
        pageContentView.setPageContentViewChange(index)
    }
    
}
