//
//  DNTool.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//
import UIKit

//屏幕宽
let SCREEN_W = UIScreen.main.bounds.width
//屏幕高
let SCREEN_H = UIScreen.main.bounds.height
//系统版本
let iOS_VERSION = (UIDevice.current.systemVersion as NSString).doubleValue

// 输出语句
func DNPrint(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}

// 返回是否是新版本
var isNewVersion: Bool {
    //取出当前是版本号
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    //取出保存在偏好设置的版本号
    let beforeVersion = UserDefaults.standard.string(forKey: "DNVersionKey") ?? ""
    //将当前的版本号偏好设置
    UserDefaults.standard.set(currentVersion, forKey: "DNVersionKey")
    //返回 连个版本号是否一致
    return currentVersion != beforeVersion
    
}
