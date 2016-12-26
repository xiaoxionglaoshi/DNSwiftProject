//
//  AppDelegate.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 创建window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        
        let picUrl = "http://ww3.sinaimg.cn/mw690/937882b5gw1f9alr6oysjj20hs0qowg0.jpg"
        
        // 检测用户是不是首次安装
        if isNewVersion {
            self.window?.rootViewController = DNGuidePageViewController()
            // 第一次加载不显示广告业,只是默默地下载下次用
            DNLaunchImageView.downLoadAdsImage(imageUrl: picUrl)
        } else {
            self.window?.rootViewController = DNTabBarViewController()
            
            // 加载广告页
            let startView: DNLaunchImageView = DNLaunchImageView.startAdsWith(imageUrl: picUrl, clickImageAction: {[weak self] in
                let vc = DNWKWebViewController()
                vc.title = "广告页面"
                vc.urlString = "https://www.google.com"
                (self?.window?.rootViewController?.childViewControllers.first as! DNNavigationController).pushViewController(vc, animated: false)
            }) as! DNLaunchImageView
            
            startView.startAnimationTime(time: 5, completionBlock: { (adsView: DNLaunchImageView) in
                print("广告结束")
            })
        }
        
        // 推送注册
        RegisterJPush(launchOptions: launchOptions)
        
        return true
    }

    // 程序暂行
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    // 程序进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    // 程序进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    // 程序从新激活
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    // 程序意外退出
    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}


