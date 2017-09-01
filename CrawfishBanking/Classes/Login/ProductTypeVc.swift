//
//  ProductTypeVc.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/19.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/19  上午9:58
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class ProductTypeVc: GYBaseBackViewController {
    
    //MARK: - Attributes
    var isPush:Bool!
    var isRevise:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "填写客户信息"
        view.backgroundColor = tableViewBgC
        if !isPush {
            navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem(nil, title: "跳过", target: self, action: #selector(ProductTypeVc.rightItemAction))
        }

    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 666:
            pushVcType(LoanType.ToJion)
            break
        case 777:
            pushVcType(LoanType.Finance)
            break
        default:
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
            let tap = UITapGestureRecognizer(target: self, action: #selector(ProductTypeVc.removeViews))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
//            let image = snapShot((appDelegate.window?.plainView)!, rect: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
            imageView.image = UIImage.init(named: "贷款产品选择")?.gaosiBlur(blur: 0.3)
            appDelegate.window?.addSubview(imageView)
            
            let subView = UINib.init(nibName: "GYReminderView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! GYReminderView
            subView.frame = CGRect(x: 25, y: Screen_Height / 2 - 125, width: Screen_Width - 50, height: 250)
            subView.layer.cornerRadius = 10
            subView.layer.masksToBounds = true
            
//            let animation = CAKeyframeAnimation(keyPath: "position")
//            let p1 = CGPoint(x: Screen_Width/2, y: 0)
//            let p2 = CGPoint(x: Screen_Width/2, y: Screen_Height/2)
//            animation.values = [p1,p2]
//            
//            animation.duration = 0.3
//            subView.layer.add(animation, forKey: "position12")
            subView.iKnownBtn.addTarget(self, action: #selector(ProductTypeVc.removeViews), for: UIControlEvents.touchUpInside)
            
            appDelegate.window?.addSubview(subView)
        
//            let subView = UIVisualEffectView.init()
//            subView.effect = UIBlurEffect.init(style: UIBlurEffectStyle.extraLight)
//            subView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height)
//            appDelegate.window?.addSubview(subView)
            
            break
        }
         
    }
    
    func fullScrrenShots() -> UIImage{
        UIGraphicsBeginImageContext((appDelegate.window?.frame.size)!)
        appDelegate.window?.layer.render(in: UIGraphicsGetCurrentContext()!)
        var image = UIGraphicsGetImageFromCurrentImageContext()

        image = UIImage.init(cgImage: (image?.cgImage!)!.cropping(to: (appDelegate.window?.frame)!)!)
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
//    func snapShot(_ view: UIView,rect:CGRect) -> UIImage{
//        
//        UIGraphicsBeginImageContext(view.bounds.size)
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        var image = UIGraphicsGetImageFromCurrentImageContext()
//
//        image = UIImage.init(cgImage: (image?.cgImage!)!.cropping(to: rect)!)
////        image?.scale = UIScreen.main.scale
//        return image!
//        
//    }
    
    func removeViews() {

        let arr = appDelegate.window?.subviews
    
        arr?.last?.removeFromSuperview()
  
        let count = arr?.count
        arr?[count! - 2].removeFromSuperview()
        
    }
    
    fileprivate func pushVcType(_ type: LoanType) {
        
        let vc = FillCustomerViewController.init(true)
        vc.loadType = type
        //MARK:- TODO
//        vc.loadType = LoanType.ToJion

        if isPush {
            vc.rightBtnHide = true
            vc.isrevise = isRevise
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        self.present(GYNavigationController(rootViewController: vc), animated: false, completion: nil)
        
    }
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    func rightItemAction() {
        
        appDelegate.window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
    
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    convenience init(_ type:Bool) {
        
        var nibNameOrNil = String?("ProductTypeVc.swift")
        
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil {
            nibNameOrNil = nil
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        isPush = type
        isRevise = type
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
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
