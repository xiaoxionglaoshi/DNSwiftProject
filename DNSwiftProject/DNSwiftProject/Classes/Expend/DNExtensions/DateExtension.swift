//
//  DateExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

/*
 case Year = "yyyy" // 1997
 case YearMonth = "yyyy-MM" // 1997-07
 case Date = "yyyy-MM-dd" // 1997-07-16
 case DateTime = "yyyy-MM-dd'T'HH:mmZ" // 1997-07-16T19:20+01:00
 case DateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ" // 1997-07-16T19:20:30+01:00
 case DateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1997-07-16T19:20:30.45+01:00
 */

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
    
}

extension Date {
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

// 格式转换
extension Date {
    
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
}

// BOOL
extension Date {
    
    // 是否是今天
    public var isToday: Bool {
        return self.isEqualToDateIgnoringTime(Date())
    }
    
    // 是否是昨天
    public var isYesterday: Bool {
        return self.isEqualToDateIgnoringTime(Date().dateBySubtractingDays(1))
    }
    
    // 是否是明天
    public var isTomorrow: Bool {
        return self.isEqualToDateIgnoringTime(Date().dateByAddingDays(1))
    }
    
    // 是否是本周
    public var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    // 是否是本月
    public var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    // 两个日期是否相等
    public func isEqualToDateIgnoringTime(_ date: Date) -> Bool {
        let comp1 = Date.components(self)
        let comp2 = Date.components(date)
        return ((comp1!.year == comp2!.year) && (comp1!.month == comp2!.month) && (comp1!.day == comp2!.day))
    }
    
    // 是否早于某日期
    func isEarlierThanDate(_ date: Date) -> Bool {
        return (self as NSDate).earlierDate(date) == self
    }
    
    // 是否晚于某日期
    func isLaterThanDate(_ date: Date) -> Bool {
        return (self as NSDate).laterDate(date) == self
    }
}

// 起始时间
extension Date {
    
    // 一天的开始
    public func dateAtStartOfDay() -> Date {
        var components = self.components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    // 一天的结束
    public func dateAtEndOfDay() -> Date {
        var components = self.components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return Calendar.current.date(from: components)!
    }
    
    // 一周的开始
    public func dateAtStartOfWeek() -> Date {
        let flags: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.weekOfYear, Calendar.Component.weekday]
        var components = Calendar.current.dateComponents(flags, from: self)
        components.weekday = Calendar.current.firstWeekday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    // 一周的结束
    public func dateAtEndOfWeek() -> Date {
        let flags: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.weekOfYear, Calendar.Component.weekday]
        var components = Calendar.current.dateComponents(flags, from: self)
        components.weekday = Calendar.current.firstWeekday + 6
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    // 一月的开始
    public func dateAtTheStartOfMonth() -> Date {
        var components = self.components()
        components.day = 1
        let firstDayOfMonthDate :Date = Calendar.current.date(from: components)!
        return firstDayOfMonthDate
    }
    
    // 一月的结束
    public func dateAtTheEndOfMonth() -> Date {
        var components = self.components()
        components.month = (components.month ?? 0) + 1
        components.day = 0
        let lastDayOfMonth :Date = Calendar.current.date(from: components)!
        return lastDayOfMonth
    }
}


// Comparing Dates
extension Date {
    
    static func componentFlags() -> Set<Calendar.Component> {
        return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear]
    }
    
    static func components(_ fromDate: Date) -> DateComponents! {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    func dateByAddingDays(_ days: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = days
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    func dateBySubtractingDays(_ days: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = (days * -1)
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    func components() -> DateComponents  {
        return Date.components(self)!
    }
    
}
