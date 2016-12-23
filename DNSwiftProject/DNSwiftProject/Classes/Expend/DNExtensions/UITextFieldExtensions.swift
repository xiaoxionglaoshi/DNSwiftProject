//
//  UITextFieldExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UITextField {
    
    // 添加文本左侧间隔大小
    public func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    // 在文本框左侧添加图标
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    // 设置提示语文字颜色
    public func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
    }
    
}
