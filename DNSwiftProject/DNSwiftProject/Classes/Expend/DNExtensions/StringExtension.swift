//
//  StringExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation

// BOOl判断
extension String {
    
    // 是否是邮箱
    public var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // 是否包含表情
    public var isContainEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    // 字符串前缀是否包含子字符串 caseSensitive(区分大小写,默认true-区分)
    public func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    //字符串后缀是否包含子字符串 caseSensitive(区分大小写,默认true-区分)
    public func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
}

// string编辑
extension String {
    // 字符串替换
    public func replace(_ substring: String, with: String) -> String {
        return replacingOccurrences(of: substring, with: with)
    }
    
    // 反向颠倒字符串
    public mutating func reverse() {
        self = String(characters.reversed())
    }
    
}

// string转换
extension String {
    
    // string转date
    public func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    // string转date 格式: yyyy-MM-dd
    public var toDate: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    // string转date 格式: yyyy-MM-dd HH:mm:ss
    public var toDateTime: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public var toDouble: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    public var toFloat: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    public var toFloat32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    public var toFloat64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    public var toInt: Int? {
        return Int(self)
    }
    
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    public var toURL: URL? {
        return URL(string: self)
    }
}

// 编码解码
extension String {
    // base64编码
    public var base64Encoded: String? {
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    // base64解码
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    // MD5加密
    var md5: String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        return String(format: hash as String)
    }
}
