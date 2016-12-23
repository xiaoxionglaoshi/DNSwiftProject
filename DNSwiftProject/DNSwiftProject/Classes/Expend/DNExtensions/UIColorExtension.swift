//
//  UIColorExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 颜色设置RGB
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat ,alpha:CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // 颜色设置Hex
    convenience init(hex:String, alpha: CGFloat = 1) {
        /// 去除错误符号 并改为16进制大写
        var hexString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        // 1. 截取 "0x" "##"  "#"
        if hexString.hasPrefix("0x") || hexString.hasPrefix("##") || hexString.hasPrefix("0#") {
            hexString = (hexString as NSString).substring(from: 2)
        } else if hexString.hasPrefix("#") {
            hexString = (hexString as NSString).substring(from: 1)
        }
        guard hexString.characters.count == 6 else {
            fatalError("不能传递无效 hex 字符串")
        }
        //获取索引
        let rIndex = hexString.index(hexString.startIndex, offsetBy: 2)
        let gIndex = hexString.index(rIndex, offsetBy: 2)
        let bIndex = hexString.index(hexString.endIndex, offsetBy: -2)
        
        // 获取 索引对应的字符串
        let rString = hexString.substring(to: rIndex)
        let gString = hexString[rIndex..<gIndex]
        let bString = hexString.substring(from: bIndex)
        
        // 获取 float 的颜色数值
        var r: UInt32 = 0 , g: UInt32 = 0 , b: UInt32 = 0
        let rScanner = Scanner.init(string: rString)
        rScanner.scanHexInt32(&r)
        let gScanner = Scanner.init(string: gString)
        gScanner.scanHexInt32(&g)
        let bScanner = Scanner.init(string: bString)
        bScanner.scanHexInt32(&b)
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
    }
    
    // 随机生成颜色
    class func randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)) ,
                            g: CGFloat(arc4random_uniform(256)) ,
                            b: CGFloat(arc4random_uniform(256))
        )
    }
}
