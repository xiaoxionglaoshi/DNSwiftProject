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


// 颜色设置RGB
func DNColor(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}

// 颜色设置Hex
func DNColor(_ hex:String) -> UIColor {
    var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased();
    
    if (cString.hasPrefix("#")) {
        let index = cString.index(cString.startIndex, offsetBy:1);
        cString = cString.substring(from: index);
    }
    if (cString.characters.count != 6) {
        return UIColor.red;
    }
    let rIndex = cString.index(cString.startIndex, offsetBy: 2);
    let rString = cString.substring(to: rIndex);
    let otherString = cString.substring(from: rIndex);
    let gIndex = otherString.index(otherString.startIndex, offsetBy: 2);
    let gString = otherString.substring(to: gIndex);
    let bIndex = cString.index(cString.endIndex, offsetBy: -2);
    let bString = cString.substring(from: bIndex);
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r);
    Scanner(string: gString).scanHexInt32(&g);
    Scanner(string: bString).scanHexInt32(&b);
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1));
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
