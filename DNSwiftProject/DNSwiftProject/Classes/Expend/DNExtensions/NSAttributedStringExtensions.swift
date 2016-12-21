//
//  NSAttributedStringExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    // 添加下划线
    public func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: range)
        return copy
    }

    // 添加斜体效果
    public func italic() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    // 添加删除线
    public func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]
        copy.addAttributes(attributes, range: range)
        return copy
    }
    
    public func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSForegroundColorAttributeName: color], range: range)
        return copy
    }
}

public func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
