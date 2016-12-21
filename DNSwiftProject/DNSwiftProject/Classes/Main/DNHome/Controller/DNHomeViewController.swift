//
//  DNHomeViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import Alamofire

class DNHomeViewController: UIViewController {
    
    var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(tempView)
        
        myLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myLabel.text = "dasjf发动机是发奖;束带结发爱的是减肥熬时间放进去哦;文件而发生大家;放假安静的收费记录;卡倒计时;浪费就;阿来得及说放假啊大事发生"
        myLabel.numberOfLines = 0
        myLabel.font = UIFont.boldSystemFont(ofSize: 13)
        myLabel.attributedText = NSAttributedString(string: myLabel.text!).underline()
        myLabel.backgroundColor = UIColor.red
        let height = myLabel.getEstimatedHeight()
        myLabel.h = height
        self.view.addSubview(myLabel)
        
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

      self.tempView.fadeTo(0.5)
     
        
    }
    
    var tempView: UIView = {
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        myView.backgroundColor = UIColor.red
        return myView
    }()

}
