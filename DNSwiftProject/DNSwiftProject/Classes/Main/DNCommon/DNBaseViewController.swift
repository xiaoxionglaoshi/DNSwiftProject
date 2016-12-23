//
//  DNBaseViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNBaseViewController: UIViewController {
    
    var navi: DNNavigationController?
    
    deinit {
        print("注销: \(self.classForCoder)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navi = self.navigationController as! DNNavigationController?
        navi?.myDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DNBaseViewController: naviDelegate {
    /// 返回按钮事件
    func backBtnClick() {
        _ = navi?.popViewController(animated: true)
    }
    
}
