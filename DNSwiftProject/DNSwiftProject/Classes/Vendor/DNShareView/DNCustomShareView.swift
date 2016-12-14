//
//  DNCustomShareView.swift
//  DNSwiftDemo
//
//  Created by mainone on 16/9/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

let originX: CGFloat = 15.0 //ico起点X坐标
let originY: CGFloat = 15.0 //ico起点Y坐标
let icoWidth: CGFloat = 57.0//正方形图标宽度
let icoAndTitleSpace: CGFloat = 10.0//图标和标题的间隔
let titleSize: CGFloat = 10.0//标签字体大小
let lastlySpace: CGFloat = 15.0//尾部间隔
let horizontalSpace: CGFloat = 15.0//横向间隔

//标签字体颜色
let titleColor = UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 1.0)

protocol DNCustomShareViewDelegate: NSObjectProtocol {
    func customShareViewButtonAction(_ shareView: DNCustomShareView, title: String);
}

class DNCustomShareView: UIView {
    var backView: UIView! //背景View
    var boderView: UIView!//中间View,主要放分享
    var firstCount: NSInteger?//第一行分享媒介数量,分享媒介最多显示2行,如果第一行显示了全部则不显示第二行
    var cancleButton: UIButton!//取消
    var showsHorizontalScrollIndicator: Bool?//是否显示滚动条
    
    weak var shareDelegate: DNCustomShareViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit custom share view!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setShareView(frame: frame)
    }
    
    /// 设置分享按钮
    ///
    /// - parameter shareArray: 按钮的种类
    /// - parameter delegate:   代理
    public func setShare(_ shareArray: Array<AnyObject>, delegate: AnyObject) {
        shareDelegate = delegate as? DNCustomShareViewDelegate;
        if firstCount! > shareArray.count || firstCount! == 0 {
            firstCount = shareArray.count;
        }
        
        let ary1 = Array(shareArray[0..<firstCount!])
        
        let ary2: Array<AnyObject>
        if shareArray.count > firstCount! {
            ary2 = Array(shareArray[firstCount!..<shareArray.count])
        } else {
            ary2 = [AnyObject]()
        }
        
        var shareScrollView = DNShareScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: DNShareScrollView.getShareScrollViewHeigt()))
        shareScrollView.setShareArray(shareArray: ary1, delegate: self)
        shareScrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator!
        boderView .addSubview(shareScrollView)
        
        if firstCount! < shareArray.count {
            self.middleLineLabel.frame = CGRect(x: 0, y: shareScrollView.frame.origin.y + shareScrollView.frame.size.height, width: self.frame.size.width, height: 0.5)
            shareScrollView = DNShareScrollView(frame: CGRect(x: 0, y: middleLineLabel.frame.origin.y + middleLineLabel.frame.size.height, width: self.frame.size.width, height: DNShareScrollView.getShareScrollViewHeigt()))
            shareScrollView.setShareArray(shareArray: ary2, delegate: self)
            shareScrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator!
            boderView.addSubview(shareScrollView)
        }
        
    }
    
    public func getBoderViewHeight(_ shareArray: [AnyObject], myFirstCount: NSInteger) -> CGFloat {
        firstCount = myFirstCount
        let height = DNShareScrollView.getShareScrollViewHeigt()
        if firstCount! > shareArray.count || firstCount! == 0 {
            return height
        }
        if firstCount! < shareArray.count {
            return height * 2 + 1
        }
        return 0
    }
    
    /// 初始化界面
    private func setShareView(frame: CGRect) {
        
        self.showsHorizontalScrollIndicator = false
        // 设置遮罩
        let shareBackView = UIView(frame: frame);
        shareBackView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        shareBackView.tag = 100
        shareBackView.isUserInteractionEnabled = true
        let myTap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction(sender:)))
        shareBackView .addGestureRecognizer(myTap)
        self.addSubview(shareBackView)
        
        // 背景View
        backView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 107))
        backView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        backView.isUserInteractionEnabled = true
        self.addSubview(backView)
        
        // 中间View,主要放分享
        boderView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: backView.frame.size.height))
        boderView.backgroundColor = UIColor.clear
        boderView.isUserInteractionEnabled = true
        self.addSubview(boderView)
        
        // 取消按钮
        cancleButton = UIButton(type: .custom)
        cancleButton.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 50)
        cancleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancleButton.setTitle("取消", for: .normal)
        let titleColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        cancleButton.setTitleColor(titleColor, for: .normal)
        cancleButton.setBackgroundImage(imageWithColor(color: UIColor.white, size: CGSize(width: 1.0, height: 1.0)), for: .normal)
        cancleButton.setBackgroundImage(imageWithColor(color: UIColor(red: 234.0/255, green: 234.0/255, blue: 234.0/255, alpha: 1.0), size: CGSize(width: 1.0, height: 1.0)), for: .highlighted)
        cancleButton.addTarget(self, action: #selector(tappedCancel), for: .touchUpInside)
        self.addSubview(cancleButton)
    }
    
    @objc private func tapGestureRecognizerAction(sender:UITapGestureRecognizer) {
        self.tappedCancel()
    }
    
    // 取消分享
    func tappedCancel() {
        debugPrint("取消")
        
        UIView.animate(withDuration: 0.25, animations: { 
            let zhezhaoView = self.viewWithTag(100)
            zhezhaoView?.alpha = 0
            
            self.backView.frame = CGRect(x: 0, y: self.frame.size.height, width: self.backView.frame.size.width, height: self.backView.frame.size.height)
            
            self.cancleButton.frame = CGRect(x: 0, y: self.cancleButton.frame.origin.y + self.backView.frame.size.height, width: self.cancleButton.frame.size.width, height: self.cancleButton.frame.size.height)
            
            self.footerView.frame = CGRect(x: 0, y: self.footerView.frame.origin.y + self.backView.frame.size.height, width: self.footerView.frame.size.width, height: self.footerView.frame.size.height)
            
            self.boderView.frame = CGRect(x: 0, y: self.boderView.frame.origin.y + self.backView.frame.size.height, width: self.boderView.frame.size.width, height: self.boderView.frame.size.height)
            
            self.headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y + self.backView.frame.size.height, width: self.headerView.frame.size.width, height: self.headerView.frame.size.height)
            
            }) { (finish) in
                if finish {
                    debugPrint("finish")
                    self.shareDelegate = nil
                    self.backView.removeFromSuperview()
                    self.removeFromSuperview()
                }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var height: CGFloat = 0.0
        
        height += self.cancleButton.frame.size.height
        self.cancleButton.frame = CGRect(x: 0, y: self.frame.size.height - height, width: cancleButton.frame.size.width, height: cancleButton.frame.size.height)
        self.cancleButton.isHidden = true
        
        height += self.footerView.frame.size.height
        self.footerView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.footerView.frame.size.width, height: self.footerView.frame.size.height)
        self.footerView.isHidden = true

        height += boderView.frame.size.height
        self.boderView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: boderView.frame.size.width, height: boderView.frame.size.height)
        self.boderView.isHidden = true
        
        
        height += self.headerView.frame.size.height
        self.headerView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.headerView.frame.size.width, height: self.headerView.frame.size.height)
        self.headerView.isHidden = true
        
        self.backView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.backView.frame.size.width, height: height)
        self.backView.isHidden = true
        
        self.cancleButton.frame = CGRect(x: 0, y: self.cancleButton.frame.origin.y + self.backView.frame.size.height, width: self.cancleButton.frame.size.width, height: self.cancleButton.frame.size.height)
        self.cancleButton.isHidden = false
        
        self.footerView.frame = CGRect(x: 0, y: self.footerView.frame.origin.y + self.backView.frame.size.height, width: self.footerView.frame.size.width, height: self.footerView.frame.size.height)
        self.footerView.isHidden = false
        
        self.boderView.frame = CGRect(x: 0, y: boderView.frame.origin.y + backView.frame.size.height, width: boderView.frame.size.width, height: boderView.frame.size.height)
        self.boderView.isHidden = false

        self.headerView.frame = CGRect(x: 0, y: headerView.frame.origin.y + backView.frame.size.height, width: headerView.frame.size.width, height: headerView.frame.size.height)
        self.headerView.isHidden = false

        self.backView.frame = CGRect(x: 0, y: self.frame.size.height, width: backView.frame.size.width, height: backView.frame.size.height)
        self.backView.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.cancleButton.frame = CGRect(x: 0, y: self.cancleButton.frame.origin.y - self.backView.frame.size.height, width: self.cancleButton.frame.size.width, height: self.cancleButton.frame.size.height)
            
            self.footerView.frame = CGRect(x: 0, y: self.footerView.frame.origin.y - self.backView.frame.size.height, width: self.footerView.frame.size.width, height: self.footerView.frame.size.height)

            self.boderView.frame = CGRect(x: 0, y: self.boderView.frame.origin.y - self.backView.frame.size.height, width: self.boderView.frame.size.width, height: self.boderView.frame.size.height)

            self.headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y - self.backView.frame.size.height, width: self.headerView.frame.size.width, height: self.headerView.frame.size.height)

            self.backView.frame = CGRect(x: 0, y: self.frame.size.height - self.self.backView.frame.size.height, width: self.backView.frame.size.width, height: self.backView.frame.size.height)

            let zhezhaoView = self.viewWithTag(100)
            zhezhaoView?.alpha = 0.9

            }) { (finish) in
                
        }
    }
    
    
    /// 通过颜色生成图片
    private func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
        
        
        
    }
    
    //MARK: lazy init
    
    // 头部分享
    private lazy var headerView = UIView()
    
    /// 设置头部样式
    public var customHeaderView: UIView? {
        didSet {
            self.headerView.removeFromSuperview()
            self.headerView = customHeaderView!
            self.addSubview(headerView)
        }
    }
    
    // 尾部分享
    private lazy var footerView = UIView()
    
    /// 设置尾部样式
    public var customFooterView: UIView? {
        didSet {
            self.footerView.removeFromSuperview()
            self.footerView = customFooterView!
            self.addSubview(footerView)
        }
    }
    
    // 中间线
    lazy var middleLineLabel: UILabel = {
        let middleLineL = UILabel()
        middleLineL.backgroundColor = UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1.0)
        self.boderView.addSubview(middleLineL)
        return middleLineL
    }()
    
}

extension DNCustomShareView: DNShareScrollViewDelegate {
    func shareScrollViewButtonAction(shareScrollView: DNShareScrollView, title: String) {
        if shareDelegate != nil {
            self.tappedCancel()
            let queue = DispatchQueue(label: "shareAction")
            queue.async {
                self.shareDelegate?.customShareViewButtonAction(self, title: title)
            }
        }
    }
}
