//
//  AppDelegate.swift
//  CrawfishBanking
//
//  Created by zhuguangyang on 2017/4/17.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//

import UIKit
import AVFoundation
import IQKeyboardManager
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        Print(UIScreen.main.bounds.size)

        IQKeyboardManager.shared().isEnabled = false

        let isFristOpen = UserDefaults.standard.object(forKey: "isFristOpenApp")
        
        if isFristOpen == nil {
            let guideVC = RNGuideViewController()
            
            guideVC.skipClosure = { [weak self]() -> Void in
                
                UIView.animate(withDuration: 1.2, animations: {
                    
                    let newTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    guideVC.view.transform = newTransform
                    
                }, completion: { (finished) in
                    
                    self!.window!.rootViewController = LoginViewController()
                    
                })
                
            }
            window?.rootViewController = guideVC
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
        } else {

        if UserAccount.loadAccount() != nil {

            window?.rootViewController = GYNavigationController(rootViewController: HomeViewController())
 
        } else {

            window?.rootViewController = LoginViewController()

        }
        }

        
        GYNetWorking.default.netWorkStatusWithBlock { (state) in
            
        }
        
        window?.makeKeyAndVisible()

        
        return true
    }
    
    
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

/*
    // 版本更新提示
    func updateversion(){
        
        let session = URLSession.shared
        
        let url = URL(string: "https://api.github.com/repos/ozner-app-ios-org/updateApi/contents/HoyoUpdateFile/hoyo.json")
        guard let u = url else{
            return
        }
        
        let request = NSMutableURLRequest(url: u)
        
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, resopnse, error) in
            
            guard let _ = data else{
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                
                let str = ((json as! [String:AnyObject])["content"] as? String)?.replacingOccurrences(of: "\n", with: "")
                
                guard let s = str else{
                    return
                }
                
                //解码
                let edcodeData = Data(base64Encoded: s, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                let decodedString = String(data: edcodeData!, encoding: String.Encoding.utf8)
                
                let data2 = decodedString?.data(using: String.Encoding.utf8)
                
                guard let _ = data2 else{
                    return
                }
                
                let dic = JSON(data: data2!)
                let versionsInAppStore = dic["result"]["version"].stringValue
                let desc = dic["result"]["updateDesc"].stringValue
                let updateType = dic["result"]["updateType"].stringValue
                let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                
                guard let _ = currentVersion else{
                    return
                }
                
                //  比较 -- A.compare(B) => 按照 A B 排列, A > B => orderedDescending
                if versionsInAppStore.compare(currentVersion!) == ComparisonResult.orderedDescending {
                    
                    if updateType == "optional"{
                        
                        
                        DispatchQueue.main.async(execute: {
//                            let alertView = SCLAlertView()
//                            alertView.addButton("前往更新 ", action: {
//                                let url = "https://itunes.apple.com/cn/app/fm-lu-xing-jie-ban-lu-xing/id1116961418?mt=8";
//                                UIApplication.shared.openURL(URL(string: url)!)
//                                
//                            })
//                            alertView.addButton("取消", action: {})
//                            
//                            alertView.showInfo("发现新版本" + versionsInAppStore, subTitle: desc)
                        })
                    }else{
                        DispatchQueue.main.async(execute: {
//                            let alertView = SCLAlertView()
//                            alertView.addButton("前往更新 ", action: {
//                                let url = "https://itunes.apple.com/cn/app/fm-lu-xing-jie-ban-lu-xing/id1116961418?mt=8";
//                                UIApplication.shared.openURL(URL(string: url)!)
//                                
//                            })
//                            
//                            alertView.showInfo("发现新版本" + versionsInAppStore, subTitle: "此版本需要强制更新")
                            
                        })
                    }
                    
                } else {
                    
                    // print("已是最新")
                    
                }
                
                
            }
            catch let error1 as NSError{
                print(error1)
            }
        })
        
        task.resume()
        
        
    }
    
    */
}

