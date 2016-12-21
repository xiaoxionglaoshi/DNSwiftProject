//
//  URLExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension URL {
    
    // 返回URL参数以字典的形式
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
    // 比较两个URL是否相同
    public func isSameWithURL(_ url: URL) -> Bool {
        if self == url {
            return true
        }
        if self.scheme?.lowercased() != url.scheme?.lowercased() {
            return false
        }
        if let host1 = self.host, let host2 = url.host {
            let whost1 = host1.hasPrefix("www.") ? host1 : "www." + host1
            let whost2 = host2.hasPrefix("www.") ? host2 : "www." + host2
            if whost1 != whost2 {
                return false
            }
        }
        let pathdelimiter = CharacterSet(charactersIn: "/")
        if self.path.lowercased().trimmingCharacters(in: pathdelimiter) != url.path.lowercased().trimmingCharacters(in: pathdelimiter) {
            return false
        }
        if (self as NSURL).port != (url as NSURL).port {
            return false
        }
        if self.query?.lowercased() != url.query?.lowercased() {
            return false
        }
        return true
    }
    
}
