//
//  User.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class User: NSObject {
    
    // 登录状态
    class var isLoginStatus: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isloginstatus")
        }
        set (isLogin) {
            UserDefaults.standard.set(isLogin, forKey: "isloginstatus")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 用户ID
    class var userID: String {
        get {
            if let userId = UserDefaults.standard.object(forKey: "userid") as? String {
                return userId.length > 0 ? userId : "-1"
            } else {
                return "-1"
            }
        }
        set (userId) {
            UserDefaults.standard.set(userId, forKey: "userid")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 昵称
    class var userNickName: String {
        get {
            if let nickName = UserDefaults.standard.object(forKey: "user_nickname") as? String {
                return nickName.length > 0 ? nickName : "未知"
            } else {
                return "未知"
            }
        }
        set(nickName) {
            UserDefaults.standard.set(nickName, forKey: "user_nickname")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 绑定邮箱
    class var userEmail: String {
        get {
            if let userEmail = UserDefaults.standard.object(forKey: "user_email") as? String {
                return userEmail.length > 0 ? userEmail : "email@example.com"
            } else {
                return "email@example.com"
            }
        }
        set(userEmail) {
            UserDefaults.standard.set(userEmail, forKey: "user_email")
            UserDefaults.standard.synchronize()
        }
    }
}
