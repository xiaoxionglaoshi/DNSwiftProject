//
//  DNLaunchImage.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/16.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNLaunchImage: NSObject {
    
    class public func getSystemLaunchImage() -> UIImage {
        let viewSize = UIScreen.main.bounds.size
        let viewOrientation: String?
        if UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portraitUpsideDown || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait {
            viewOrientation = "Portrait"
        } else {
            viewOrientation = "Landscape"
        }
        var launchImage: String?
        let imageDict: [[AnyHashable: Any]] = Bundle.main.infoDictionary?["UILaunchImages"] as! [[AnyHashable : Any]]
        for dict: [AnyHashable: Any] in imageDict {
            let imageSize = CGSizeFromString(dict["UILaunchImageSize"] as! String)
            if __CGSizeEqualToSize(imageSize, viewSize) && viewOrientation == (dict["UILaunchImageOrientation"] as! String){
                launchImage = dict["UILaunchImageName"] as! String?
            }
        }
        
        return UIImage(named: launchImage!)!
    }
}
