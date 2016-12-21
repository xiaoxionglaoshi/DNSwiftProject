//
//  NSDictionaryExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation

public extension NSDictionary {
    // json to dictionary
    public convenience init ? (json: String) {
        if let data = (try? JSONSerialization.jsonObject(with: json.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            self.init(dictionary: data)
        } else {
            self.init()
            return nil
        }
    }
    
    // dictionary to json
    public func formatJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return String(jsonStr ?? "")
        }
        return nil
    }
}
