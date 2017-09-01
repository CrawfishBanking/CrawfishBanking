//
//  LoansVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/3.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/3  下午2:50
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class LoansVc: GYBaseViewController {
    
    //MARK: - Attributes
    var bootomView: LoansBootomView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    fileprivate func initUI() {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "放款"))
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 55, width: Screen_Width, height: 220)
        view.addSubview(imageView)
        
        bootomView = UINib.init(nibName: "LoansBootomView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! LoansBootomView
        bootomView.frame = CGRect(x: 0, y: imageView.gy_bootom + 45, width: Screen_Width, height: view.gy_height - imageView.gy_height - 45)
        view.addSubview(bootomView)
        
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
