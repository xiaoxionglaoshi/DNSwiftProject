//
//  DNMainModel.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/28.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import SwiftyJSON

class DNMainModel: NSObject {
    var clsName: String!
    var title: String!
    var visitorInfo: VisitorInfo!
    var imageName: String!
    
    init(fromJson json: JSON) {
        super.init()
        self.clsName = json["clsName"].stringValue
        self.title = json["title"].stringValue
        self.imageName = json["imageName"].stringValue
        let visitorDict = json["visitorInfo"]
        self.visitorInfo = VisitorInfo(fromJson: visitorDict)
    }
    
}

class VisitorInfo: NSObject {
    var imageName: String!
    var message: String!
    
    init(fromJson json: JSON) {
        self.imageName = json["imageName"].stringValue
        self.message = json["message"].stringValue
    }
}
