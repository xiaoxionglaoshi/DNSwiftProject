//
//  DNCycleModel.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/23.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNCycleModel: NSObject {
    // 图片字符串
    var imageString: String!
    // 提示语
    var title: String!
    
    init(fromDict dict: Dictionary<String, String>) {
        super.init()
        self.imageString = dict["imageString"] ?? "xxx"
        self.title = dict["title"] ?? "ooo"
    }
}
