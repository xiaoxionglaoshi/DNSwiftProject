//
//  DNTool.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//
import UIKit


func DNPrint(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}


 func getCurrentDateString() ->String{
    let date = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy年MM月dd日"
    let currentDateString = timeFormatter.string(from: date) as String
    return currentDateString
}
