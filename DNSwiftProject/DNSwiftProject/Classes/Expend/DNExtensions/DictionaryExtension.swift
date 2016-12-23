//
//  DictionaryExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation

public extension Dictionary {
    // 字典中指定key是否存在
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    // dictionary 转 data
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return jsonData
        } catch {
            return nil
        }
    }
    
    // dictionary 转 json.
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
