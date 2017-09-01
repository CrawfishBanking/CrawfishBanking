//
//  QuotaUnkownVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/15.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/15  下午4:59
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class QuotaUnkownVc: GYBaseViewController {
    
    //MARK: - Attributes

    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var lb: UILabel!
    
    var type: LoanState!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    convenience init(_ loadType: LoanState) {
        
        var nibNameOrNil = String?("QuotaUnkownVc.swift")
        
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil {
            nibNameOrNil = nil
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        self.type = loadType
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    
    @IBAction func sureAction(_ sender: Any) {
        
        
        switch type! {
        case LoanState.QuotaunKown:
            
            self.present(GYNavigationController(rootViewController:  ProductTypeVc.init(false)), animated: false, completion: nil)
            break
        case LoanState.Checking:
            break
        case LoanState.CheckSuccess:
            break
        case LoanState.updated:
            break
            
        }
        
        
    }
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    fileprivate func initUI() {
        
        switch type! {
        case LoanState.QuotaunKown:
            loadUI("BG1", btnHexColor: "fe640e", lbText: "融资额度不明,是否现在就去完善客户信息?")
            break
        case LoanState.Checking:
            loadUI("BG2", btnHexColor: "3ed6ff", lbText: "您有一笔贷款正在审核中,是否查看?")
            break
        case LoanState.CheckSuccess:
            loadUI("BG3", btnHexColor: "0ad46e", lbText: "您的贷款审核成功,是否立即查看?")
            break
        case LoanState.updated:
            loadUI("BG4", btnHexColor: "8687F3", lbText: "您的还款信息已更新,是否查看?")
            break
        
        }
        
    }
    
    fileprivate func loadUI(_ imgName:String,btnHexColor:String,lbText:String) {
        
        bgImage.image = UIImage(named: imgName)
        sureBtn.backgroundColor = UIColor.init(hexColor: btnHexColor)
        lb.text = lbText
        
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
