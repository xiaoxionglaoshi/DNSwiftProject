//
//  DNNotificationView.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import Spring

enum DNNotificationShowType : Int {
    case top
    case bottom
}

class DNNotificationView: UIView {

    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    var showType : DNNotificationShowType?
    let tap = UITapGestureRecognizer() //手势
    let _showView = SpringView() //通知的弹框
    let showText = UILabel() //通知内容
    let iconImg  = UIImageView()
    
    
    //init 调用方法
    init(title: String?,showType:DNNotificationShowType? ) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        if title == nil {
            return
        }
        self.showType = showType
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        // 添加手势
        tap.addTarget(self, action: #selector(self.removeWindowsView(_:)))
        self.addGestureRecognizer(tap)
        
        _showView.backgroundColor = UIColor.white
        _showView.layer.shadowColor = UIColor.lightGray.cgColor
        _showView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        if (self.showType==DNNotificationShowType(rawValue: 0)) {
            _showView.frame = CGRect(x: 0, y: -64, width: screen_width , height: 64)
        } else {
            _showView.frame = CGRect(x: 0, y: screen_height, width: screen_width , height: 64)
        }
        
        //通知小图标
        iconImg.frame = CGRect(x: 2, y: 15, width: 50, height: 50)
        iconImg.center.x = _showView.frame.size.height/2;
        iconImg.image = UIImage(named: "news.png")
        _showView .addSubview(iconImg)
        
        //通知消息
        showText.frame = CGRect(x: 75, y: 15, width: screen_width-70, height: 60)
        showText.text = title;
        showText.textColor = UIColor.brown
        showText.textAlignment=NSTextAlignment.left
        _showView .addSubview(showText)
        
        self.addSubview(_showView)
    }
    
    func removeWindowsView(_ thetap:UITapGestureRecognizer) {
        //        dismiss()
    }
    
    //通知条显示
    func show() {
        UIApplication.shared.windows[0].addSubview(self)
        //1.动画显示
        SpringAnimation.springWithCompletion(duration: 0.5, animations: {
            //从上面
            if (self.showType==DNNotificationShowType(rawValue: 0)){
                self._showView.frame = CGRect(x: 0, y: -10, width: self.screen_width , height: 74)
            }else{
                //从下面
                self._showView.frame = CGRect(x: 0, y: self.screen_height-64, width: self.screen_width , height: 74)
            }
        }, completion: {
            (finished:Bool) -> Void in
            
            //结束后回到初始化的位置，然后调用移除
            SpringAnimation.springWithDelay(duration: 1, delay: 2, animations: {
                if (self.showType==DNNotificationShowType(rawValue: 0)){
                    self._showView.frame = CGRect(x: 0, y: -64, width: self.screen_width , height: 64)
                }else{
                    self._showView.frame = CGRect(x: 0, y: self.screen_height, width: self.screen_width , height: 64)
                }
                
                //为了有抽屉的效果，延迟一下
                //延时1秒执行
                let time: TimeInterval = 2
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                    //code
                    self.dismiss()
                }
            })
        })
    }
    
    //通知条消失
    func dismiss() {
        SpringAnimation.springWithCompletion(duration: 1, animations: {
            if (self.showType==DNNotificationShowType(rawValue: 0)){
                self._showView.frame = CGRect(x: 0, y: -64, width: self.screen_width , height: 64)
            }else{
                self._showView.frame = CGRect(x: 0, y: self.screen_height, width: self.screen_width , height: 64)
            }
        }, completion: {
            (finished:Bool) -> Void in
            self._showView .removeFromSuperview()
            self.removeGestureRecognizer(self.tap)
            self.removeFromSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
