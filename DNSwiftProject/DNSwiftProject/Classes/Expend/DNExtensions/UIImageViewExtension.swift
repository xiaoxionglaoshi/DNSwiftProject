//
//  UIImageViewExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // 模糊
    func blur(withStyle: UIBlurEffectStyle = .light) {
        let blurEffect = UIBlurEffect(style: withStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
        self.clipsToBounds = true
    }
    
    func blurred(withStyle: UIBlurEffectStyle = .light) -> UIImageView {
        return self.blurred(withStyle: withStyle)
    }
}
