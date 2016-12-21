//
//  UILabelExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UILabel {
    
    // 获取估算大小
    public func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    // 获取估算高度
    public func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    // 获取估算宽度
    public func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)).width
    }
    
    // 设置文字 带动画
    public func setText(_ text: String?, animated: Bool, duration: TimeInterval?) {
        if animated {
            UIView.transition(with: self, duration: duration ?? 0.3, options: .transitionCrossDissolve, animations: { () -> Void in
                self.text = text
            }, completion: nil)
        } else {
            self.text = text
        }
    }
    
}
