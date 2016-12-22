//
//  DNNetwork.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

/*
    接口: 🌏
    错误: ❌
    正确: ✅
 */

import UIKit
import SwiftyJSON
import Alamofire

typealias DNNetworkSuccess = (_ jsonData: JSON?) -> Void
typealias DNNetworkFailure = (_ error: Error?) -> Void
typealias DNProgressValue = (_ progress: Double) -> Void

private let DNNetworkShareInstance = DNNetwork()

class DNNetwork: NSObject {
    
    // 创建一个单例
    open class var shared: DNNetwork {
        return DNNetworkShareInstance
    }
    
    /// 主机域名
    private var host: String {
        get {
            return DNConfig.getHost()
        }
    }
    
    // 请求配置
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        return SessionManager(configuration: configuration)
    }()
    
    /// GET请求
    ///
    /// - parameter url:        请求接口 不包含主机域名
    /// - parameter parameters: 参数
    /// - parameter success:    成功后回调 返回JSON数据
    /// - parameter failure:    失败后回调
    open func GET(url: String, parameters: [String: AnyObject]? = [:], success: @escaping DNNetworkSuccess, failure: @escaping DNNetworkFailure) {
        
        var requestUrlString = url
        if !url.hasPrefix("http://") && !url.hasPrefix("https://") {
            requestUrlString = self.host + url
        }
        DNPrint("🌏GET🌏\(requestUrlString)🌏GET🌏")
        sessionManager.request(requestUrlString, parameters: parameters).responseJSON { (response) in
            guard response.result.isSuccess else {
                DNPrint("❌GET❌\(response.result.error)❌GET❌")
                failure(response.result.error)
                return
            }
            let json = JSON(data: response.data!);
            DNPrint("✅GET✅\(json)✅GET✅")
            success(json)
        }
    }
    
    
    open func POST(url: String, parameters: [String: AnyObject]? = [:], success: @escaping DNNetworkSuccess, failure: @escaping DNNetworkFailure) {
        var requestUrlString = url
        if !url.hasPrefix("http://") && !url.hasPrefix("https://") {
            requestUrlString = self.host + url
        }
        DNPrint("🌏POST🌏\(requestUrlString)🌏POST🌏")
        sessionManager.request(requestUrlString, method: .post, parameters: parameters).responseJSON { (response) in
            guard response.result.isSuccess else {
                DNPrint("❌POST❌\(response.result.error)❌POST❌")
                failure(response.result.error)
                return
            }
            let json = JSON(data: response.data!);
            DNPrint("✅POST✅\(json)✅POST✅")
            success(json)
        }
    }
    
    /// 获取目录中的json文件内容
    ///
    /// - parameter forResource: 文件名
    /// - parameter success:     成功后回调
    open func GetJsonData(forResource: String?, success: DNNetworkSuccess) {
        //1.获取JSON文件路径
        guard let jsonPath = Bundle.main.path(forResource: forResource, ofType: nil) else {
            DNPrint("❌JSON❌没有获取到对应的文件路径❌JSON❌")
            return
        }
        //2.读取json文件中的内容
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            DNPrint("❌JSON❌没有获取到json文件中数据❌JSON❌")
            return
        }
        let json = JSON(data: jsonData);
        DNPrint("✅JSON✅\(json)✅JSON✅")
        success(json)
    }
    
    /// 上传文件
    ///
    /// - parameter url:           上传地址
    /// - parameter parameters:    参数
    /// - parameter datas:         文件data
    /// - parameter progressValue: 上传进度
    /// - parameter success:       上传成功
    /// - parameter failure:       上传失败
    open func upload(url: String, parameters: [String: AnyObject]?, datas: [UIImage], progressValue: @escaping DNProgressValue, success: @escaping DNNetworkSuccess, failure: @escaping DNNetworkFailure) {

        //上传文件
        sessionManager.upload(multipartFormData: { multipartFormData in
            // 多个文件添加
            for index in 0..<datas.count {
                DNPrint("添加文件")
                let data = UIImageJPEGRepresentation(datas[index], 0.01)
                multipartFormData.append(data!, withName: "data\(index)")
            }
            // 同时传参数
            if !(parameters?.isEmpty)! {
                DNPrint("参数: \(parameters)")
                for (key, value) in parameters! {
                    let parData = value.data(using: String.Encoding.utf8.rawValue)
                    multipartFormData.append(parData!, withName: key)
                }
            }
            
            }, to: url) { (encodingResult) in
                // 返回结果
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                            guard response.result.isSuccess else {
                                DNPrint("❌UPLOAD❌\(response.result.error)❌UPLOAD❌")
                                return
                            }
                            let json = JSON(data: response.data!);
                            DNPrint("✅UPLOAD✅\(response)✅UPLOAD✅")
                            success(json)
                        }.uploadProgress { progress in
                            DNPrint("上传进度: \(progress.fractionCompleted)")
                            progressValue(progress.fractionCompleted)
                    }
                case .failure(let encodingError):
                    DNPrint("❌UPLOAD❌\(encodingError)❌UPLOAD❌")
                    failure(encodingError)
                }
        }
    }
    
    
}
