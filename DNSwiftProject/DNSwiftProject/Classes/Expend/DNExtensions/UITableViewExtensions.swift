//
//  UITableViewExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

public extension UITableView {
    // 返回section最后一行
    public func indexPathForLastRow(in section: Int) -> IndexPath? {
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    // 返回table最后一行
    public var indexPathForLastRow: IndexPath? {
        guard numberOfRows > 0 else {
            return nil
        }
        return IndexPath(row: numberOfRows - 1, section: lastSection)
    }
    
    // 返回table最后一个section
    var lastSection: Int {
        guard numberOfSections > 1 else {
            return 0
        }
        return numberOfSections - 1
    }
    
    // 移除footerView
    public func removeTableFooterView() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    // 移除headerView
    public func removeTableHeaderView() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    
    // 滚动到底部
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    // 滚动到顶部
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    public var numberOfRows: Int {
        var section = 0
        var rowCount = 0
        while section < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
}
