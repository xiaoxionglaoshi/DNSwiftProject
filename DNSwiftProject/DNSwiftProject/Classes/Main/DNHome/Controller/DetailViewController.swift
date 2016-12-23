//
//  DetailViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DetailViewController: DNBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        DNJPushManager.shared.myDelegate = self
        
        
        let img = UIImage(named: "tx")
        self.navigationItem.replaceTitle(with: img!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    var message: Dictionary<String, Any>? {
        didSet {
            print("pushVC: \(message)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alertView = DNCustomAlert(title: "提示", message: "这是一个自定义的提示框,可不要小瞧我哦?", cancelButtonTitle: "取消", sureButtonTitle: "确定")
        alertView.show()
        alertView.clickIndexClosure { (index) in
            print("我点击的是: \(index)")
        }
        
        let notiView = DNNotificationView(title: "貌似你的应用不错哦", showType: .top)
        notiView.show()
    }

}

extension DetailViewController: DNJPushDelegate {
    func receiveMessage(_ userInfo: Dictionary<String, Any>) {
        message = userInfo
    }
}
