//
//  DNHomeRequest.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

typealias DNHomeNetworkSuccess = (_ homeModel: DNHomeModel?) -> Void
typealias DNHomeNetworkFailure = (_ error: Error?) -> Void

class DNHomeRequest: NSObject {
    
    class func getHomeList(url: String, parameters: [String: AnyObject]?, success: @escaping DNHomeNetworkSuccess, failure: @escaping DNHomeNetworkFailure) {
        DNNetwork.shared.GET(url: url, parameters: parameters, success: { (json) in
            // 转模型
            let model = DNHomeModel(fromJson: json!)
            success(model)
            }) { (error) in
                failure(error)
        }
    }
    
    class func getJson(for Resource: String?, array: ([DNMainModel]) -> Void) {
        DNNetwork.shared.GetJsonData(forResource: Resource) { (json) in
            let arr = json?.arrayValue
            var tempArr = [DNMainModel]()
            arr?.forEach({ (item) in
                let model = DNMainModel(fromJson: item)
                tempArr.append(model)
            })
            array(tempArr)
        }
    }
    
}
