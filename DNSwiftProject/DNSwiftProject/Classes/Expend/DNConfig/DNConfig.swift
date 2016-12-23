//
//  DNConfig.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNConfig: NSObject {
    class func getHost() -> String {
        #if DEBUG
            return "http://localhost:8080/"
        #else
            return "https://xiaoxionglaoshi.herokuapp.com/"
        #endif
    }
}

// 极光推送参数配置
let JPushAppKey = "2c8a39f03e76c83807c22634"
let JPushChannel = "AppStore"
let JPushIsProduction = false


