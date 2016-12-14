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

}

extension DetailViewController: DNJPushDelegate {
    func receiveMessage(_ userInfo: Dictionary<String, Any>) {
        message = userInfo
    }
}
