//
//  BlockTap.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

open class BlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTapsRequired = tapCount
        
        #if os(iOS)
            self.numberOfTouchesRequired = fingerCount
        #endif
        self.tapAction = action
        self.addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }
    
    open func didTap (_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}
