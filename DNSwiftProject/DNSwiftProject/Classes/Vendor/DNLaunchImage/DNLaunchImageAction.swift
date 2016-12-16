//
//  DNLaunchImageAction.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/16.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNLaunchImageAction: UIImageView {

    var target: AnyObject?
    var action: Selector?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.target?.responds(to: self.action))! {
            target?.perform(self.action!, with: self, afterDelay: 0.0)
        }
    }
}
