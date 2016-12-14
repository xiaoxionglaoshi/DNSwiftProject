//
//  DNTabBarViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }
    
    // 添加子视图控制器
    private func addChildViewControllers() {
        addChildViewController("DNHomeViewController", title: "首页", imageName: "tabbar_first")
        addChildViewController("DNAddressViewController", title: "联系人", imageName: "tabbar_second")
        addChildViewController("DNFoundViewController", title: "发现", imageName: "tabbar_third")
        addChildViewController("DNMineViewController", title: "我的", imageName: "tabbar_fourth")
    }
    
    private func addChildViewController(_ vcName: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        // 将字符串转化为类,默认情况下命名空间就是项目名称,也可以自行修改
        let cls: AnyClass? = NSClassFromString(ns + "." + vcName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应属性
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red: 0.0, green: 190.0/255.0, blue: 12.0/255.0, alpha: 10)], for: .selected)
        // 给每个控制器包装一个导航控制器
        let nav = DNNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
