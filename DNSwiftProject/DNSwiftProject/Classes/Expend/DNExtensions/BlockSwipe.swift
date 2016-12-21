//
//  BlockSwipe.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

open class BlockSwipe: UISwipeGestureRecognizer {
    private var swipeAction: ((UISwipeGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (direction: UISwipeGestureRecognizerDirection,
                             fingerCount: Int = 1,
                             action: ((UISwipeGestureRecognizer) -> Void)?) {
        self.init()
        self.direction = direction
        #if os(iOS)
            numberOfTouchesRequired = fingerCount
        #endif
        swipeAction = action
        addTarget(self, action: #selector(BlockSwipe.didSwipe(_:)))
    }
    
    open func didSwipe (_ swipe: UISwipeGestureRecognizer) {
        swipeAction? (swipe)
    }
}
