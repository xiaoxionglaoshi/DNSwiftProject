//
//  BlockPinch.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

#if os(iOS)
open class BlockPinch: UIPinchGestureRecognizer {
    private var pinchAction: ((UIPinchGestureRecognizer) -> Void)?
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    public convenience init (action: ((UIPinchGestureRecognizer) -> Void)?) {
        self.init()
        self.pinchAction = action
        self.addTarget(self, action: #selector(BlockPinch.didPinch(_:)))
    }
    open func didPinch (_ pinch: UIPinchGestureRecognizer) {
        pinchAction? (pinch)
    }
}
    
#endif
