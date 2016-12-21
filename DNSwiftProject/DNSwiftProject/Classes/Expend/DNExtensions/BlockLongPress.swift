//
//  BlockLongPress.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

open class BlockLongPress: UILongPressGestureRecognizer {
    private var longPressAction: ((UILongPressGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (action: ((UILongPressGestureRecognizer) -> Void)?) {
        self.init()
        longPressAction = action
        addTarget(self, action: #selector(BlockLongPress.didLongPressed(_:)))
    }
    
    open func didLongPressed(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == UIGestureRecognizerState.began {
            longPressAction?(longPress)
        }
    }
}
