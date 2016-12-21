//
//  DateExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation

extension Date {
    
    public static let minutesInAWeek = 24 * 60 * 7
    
    // 初始化日期-字符串格式
    public init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    // 初始化日期从字符串返回一个http响应
    public init? (httpDateString: String) {
        if let rfc1123 = Date(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self = rfc1123
            return
        }
        if let rfc850 = Date(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self = rfc850
            return
        }
        if let asctime =  Date(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self = asctime
            return
        }
        return nil
    }
    
    // 将日期转换为字符串
    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    // 将日期转换为字符串格式
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // 计算从给定日期到现在有多少天
    public func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/86400)
        return diff
    }
    
    // 计算从给定日期到现在有多少小时
    public func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/3600)
        return diff
    }
    
    // 计算从给定日期到现在有多少分钟
    public func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/60)
        return diff
    }
    
    // 计算从给定日期到现在有多少秒
    public func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }
    
    // 当前时间
    public func getCurrentDateString() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy年MM月dd日"
        let currentDateString = timeFormatter.string(from: date) as String
        return currentDateString
    }
    
    // 时间标签
    public func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        
        if components.year! >= 1 {
            return "\(components.year)年前"
        } else if components.month! >= 1 {
            return "\(components.month)月前"
        } else if components.day! >= 1 {
            return "\(components.day)天前"
        } else if components.hour! >= 1 {
            return "\(components.hour)小时前"
        } else if components.minute! >= 1 {
            return "\(components.minute)分钟前"
        } else if components.second == 0 {
            return "刚刚"
        } else {
            return "\(components.second)秒前"
        }
    }
    
    // 是否是今天
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    // 是否是昨天
    public var isYesterday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        return format.string(from: self) == format.string(from: yesterDay!)
    }
    
    // 是否是明天
    public var isTomorrow: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return format.string(from: self) == format.string(from: tomorrow!)
    }
    
    // 是否是本月
    public var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    // 是否是本周
    public var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    // 工作日的日期
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    // 获取月
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    // 年
    public var year: Int {
        return NSCalendar.current.component(Calendar.Component.year, from: self)
    }
    
    // 月
    public var month: Int {
        return NSCalendar.current.component(Calendar.Component.month, from: self)
    }
    
    // 日
    public var day: Int {
        return NSCalendar.current.component(Calendar.Component.day, from: self)
    }
    
    // 时
    public var hour: Int {
        return NSCalendar.current.component(Calendar.Component.hour, from: self)
    }
    
    // 钟
    public var minute: Int {
        return NSCalendar.current.component(Calendar.Component.minute, from: self)
    }
    
    // 秒
    public var second: Int {
        return NSCalendar.current.component(Calendar.Component.second, from: self)
    }
}
