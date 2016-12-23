//
//  UITextViewExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

public extension UITextView {
    
    // 滚动到底部
    public func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }
    
    // 滚动到顶部
    public func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
    
}
