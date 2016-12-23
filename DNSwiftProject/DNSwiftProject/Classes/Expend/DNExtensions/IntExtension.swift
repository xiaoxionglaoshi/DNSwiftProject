//
//  IntExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension Int {
    
    // 生成随机数
    public static func randomBetween(min: Int, max: Int) -> Int {
        let delta = max - min
        return min + Int(arc4random_uniform(UInt32(delta)))
    }
    
    // 数字转罗马数字
    public var romanNumeral: String? {
        guard self > 0 else {
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if (div > 0) {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        guard romanValue.characters.count > 0 else {
            return nil
        }
        return romanValue
    }
}
