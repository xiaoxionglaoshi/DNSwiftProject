//
//  DNMessages.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/28.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import SwiftMessages

private let DNMessagesShareInstance = DNMessages()

class DNMessages: SwiftMessages {
    // 创建一个单例
    open class var shared: DNMessages {
        return DNMessagesShareInstance
    }
    
    /// 显示信息
    ///
    /// - parameter title:  标题
    /// - parameter body:   显示内容
    /// - parameter theme:  类型(info: 信息, error: 错误, success: 成功, warning: 警告)
    /// - parameter level:  显示位置(UIWindowLevelNormal, UIWindowLevelAlert, UIWindowLevelStatusBar)
    /// - parameter layout: 显示区域大小(MessageView, CardView, TabView, StatusLine, MessageViewIOS8)
    open func showMessage(_ title: String?, body: String?, theme: Theme, level: UIWindowLevel, layout: MessageView.Layout) {
       
        let messageTitle = title ?? ""
        let messageBody = body ?? ""
        
        var message: MessageView = try! SwiftMessages.viewFromNib()
        switch layout {
        case .CardView, .MessageView, .MessageViewIOS8, .StatusLine, .TabView:
            message = MessageView.viewFromNib(layout: layout)
        }
        
        message.configureTheme(theme)
        message.configureDropShadow()
        
        message.configureContent(title: messageTitle, body: messageBody)
        message.button?.isHidden = true
        var messageConfig = SwiftMessages.defaultConfig
        messageConfig.presentationContext = .window(windowLevel: level)
        messageConfig.duration = .seconds(seconds: 3)
        SwiftMessages.show(config: messageConfig, view: message)
    }
    
    /// 错误
    open func showError(_ title: String?, body: String?) {
        self.showMessage(title, body: body, theme: .error, level: UIWindowLevelStatusBar, layout: .StatusLine)
    }
    
    /// 警告
    open func showWarning(_ title: String?, body: String?) {
        self.showMessage(title, body: body, theme: .warning, level: UIWindowLevelStatusBar, layout: .StatusLine)
    }
    
    
}
