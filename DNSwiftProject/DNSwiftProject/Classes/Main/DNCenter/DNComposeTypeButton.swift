//
//  DNComposeTypeButton.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    //点击按钮展示控制器的类型
    var clsName: String?
    
    /// 使用图像名称、标题创建按钮， 按钮布局从xib加载
    class func composeTypeButton(imageName:String, title: String) ->DNComposeTypeButton {
      let btn = UINib(nibName: "DNComposeTypeButton", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DNComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLab.text = title
        
        return btn
    }

}
