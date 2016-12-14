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
        // 检测用户是不是首次安装
        if !UserDefaults.standard.bool(forKey: "firstLauch") {
            self.window?.rootViewController = DNGuidePageViewController()
            UserDefaults.standard.set(true, forKey: "firstLauch")
        } else {
            self.window?.rootViewController = DNTabBarViewController()
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


