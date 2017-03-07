//
//  DNTabBarViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNTabBarViewController: UITabBarController {
    
    fileprivate lazy var composeBtn : UIButton = UIButton.imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        steupComposeBtn()
    }
    
    // 添加子视图控制器
    private func addChildViewControllers() {
        let homeVC      = addChildViewController("DNHomeViewController", title: "首页", imageName: "tabbar_first")
        let addressVC   = addChildViewController("DNAddressViewController", title: "联系人", imageName: "tabbar_second")
        let centerBtn   = addChildViewController("ViewController", title: "11", imageName: "11")
        let foundVC     = addChildViewController("DNFoundViewController", title: "发现", imageName: "tabbar_third")
        let mineVC      = addChildViewController("DNMineViewController", title: "我的", imageName: "tabbar_fourth")
        viewControllers = [homeVC, addressVC, centerBtn, foundVC, mineVC]
    }
    
    private func addChildViewController(_ vcName: String, title: String, imageName: String) -> UIViewController{

        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        // 将字符串转化为类,默认情况下命名空间就是项目名称,也可以自行修改
        let cls: AnyClass? = NSClassFromString(ns + "." + vcName)
        guard let vcClass = cls as? UIViewController.Type else {
            return UIViewController()
        }
        let vc = vcClass.init()
        // 设置对应属性
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red: 0.0, green: 190.0/255.0, blue: 12.0/255.0, alpha: 10)], for: .selected)
        // 给每个控制器包装一个导航控制器485851
        let nav = DNNavigationController(rootViewController: vc)
        return nav
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc fileprivate func composeBtnAction(){
        
        //实例view
        let view = DNComposeTypeView.composeTypeView()
        //展示
        view.show { [weak view] (clsName) in
            //展现撰写微博控制器
            guard let clsName = clsName,
                let cls = NSClassFromString(Bundle.main.infoDictionary?["CFBundleExecutable"] as! String + "." + clsName) as? UIViewController.Type else{
                    view?.removeFromSuperview()
                    return
            }
            
            let vc = cls.init()
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: {
                view?.removeFromSuperview()
            })
        }
    }
}

// MARK: - 设置界面
extension DNTabBarViewController {
    //设置撰写按钮
    fileprivate func steupComposeBtn() {
        tabBar.addSubview(composeBtn)
        //设置位置
        let count = CGFloat(childViewControllers.count)
        // 将向内缩进宽度
        let w = tabBar.w / count
        //正数 向内部缩进,负数向外外部扩展  insetBy 左右同时往内缩小
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        //添加点击事件
        composeBtn.addTarget(self, action: #selector(composeBtnAction), for: .touchUpInside)
    }
}

