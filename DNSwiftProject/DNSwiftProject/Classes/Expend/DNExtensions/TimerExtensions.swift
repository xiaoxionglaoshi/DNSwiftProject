//
//  TimerExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation

extension Timer {
    
    // 每隔seconds秒运行一次 取消执行: timer.invalidate()
    public static func runThisEvery(seconds: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    // seconds秒后运行
    public static func runThisAfterDelay(seconds: Double, after: @escaping () -> ()) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    
    // seconds秒后运行 可设置线程
    public static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
