//
//  UIButtonExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func imageButton(_ imageName: String, backgroundImageName: String) -> Self {
        let button = self.init()
        button.setImage(UIImage(named: imageName)!, for: .normal)
        let imageNameHL = imageName.appending("_highlighted")
        button.setImage(UIImage(named: imageNameHL)!, for: .highlighted)
        button.setBackgroundImage(UIImage(named: backgroundImageName)!, for: .normal)
        let backgroundImageNameHL = backgroundImageName.appending("_highlighted")
        button.setBackgroundImage(UIImage(named: backgroundImageNameHL)!, for: .highlighted)
        button.sizeToFit()
        return button
    }
    
    class func textButton(_ title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor, backgroundImageName: String?) -> Self {
        let button = self.init()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        if backgroundImageName != nil {
            button.setBackgroundImage(UIImage(named: backgroundImageName!)!, for: .normal)
            let backgroundImageNameHL = backgroundImageName?.appending("_highlighted")
            button.setBackgroundImage(UIImage(named: backgroundImageNameHL!)!, for: .highlighted)
        }
        button.sizeToFit()
        return button
    }
}
