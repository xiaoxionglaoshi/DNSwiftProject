//
//  DNHomeModel.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import SwiftyJSON

class DNHomeModel: NSObject {
    
    var titleImage: String!
    var titleName: String!
    var detail: String!
    
    init(fromJson json: JSON) {
        super.init()
        self.titleImage = json["titleImage"].stringValue 
        self.titleName = json["titleName"].stringValue
        self.detail = json["detail"].stringValue
    }

}
