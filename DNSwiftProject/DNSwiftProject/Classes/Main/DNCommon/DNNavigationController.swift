//
//  DNNavigationController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

protocol naviDelegate: class {
    /// 返回按钮事件
    func backBtnClick()
}

class DNNavigationController: UINavigationController {
    
    weak var myDelegate: naviDelegate?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 拦截push事件,当不是根视图的时候隐藏Tabbar,并自定义返回按钮样式
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navi_back"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBackClick() {
        self.myDelegate?.backBtnClick()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension DNNavigationController: UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self;
        // 设置导航栏样式
        let navBar = UINavigationBar.appearance()
        navBar.barStyle = .blackTranslucent
        navBar.barTintColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1
    }
}
