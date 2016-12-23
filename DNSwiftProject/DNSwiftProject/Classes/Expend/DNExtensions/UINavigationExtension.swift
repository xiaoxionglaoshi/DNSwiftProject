//
//  UINavigationExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // pop
    public func popViewController(completion: (()->Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    // push
    public func pushViewController(viewController: UIViewController, completion: (()->Void)? = nil)  {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    // 使导航控制器的导航栏透明
    func makeTransparent(withTint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = withTint
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: withTint]
    }
    
}

extension UINavigationBar {
    
    // 设置导航栏透明
    func makeTransparent(withTint: UIColor = .white) {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        tintColor = withTint
        titleTextAttributes = [NSForegroundColorAttributeName: withTint]
    }
    
    // 设置导航栏颜色
    func setColors(background: UIColor, text: UIColor) {
        self.isTranslucent = false
        self.backgroundColor = background
        self.barTintColor = background
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.tintColor = text
        self.titleTextAttributes = [NSForegroundColorAttributeName: text]
    }
}

extension UINavigationItem {
    
    // title设置成图片
    public func replaceTitle(with image: UIImage) {
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image
        self.titleView = logoImageView
    }
}
