//
//  DNShareScrollView.swift
//  DNSwiftDemo
//
//  Created by mainone on 16/9/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

protocol DNShareScrollViewDelegate: NSObjectProtocol {
    func shareScrollViewButtonAction(shareScrollView: DNShareScrollView, title: String)
}

class DNShareScrollView: UIScrollView {
    var S_originX: CGFloat = 0.0
    var S_originY: CGFloat = 0.0
    var S_icoWidth: CGFloat = 0.0
    var S_icoAndTitleSpace: CGFloat = 0.0
    var S_titleSize: CGFloat = 0.0
    var S_lastlySpace: CGFloat = 0.0
    var S_horizontalSpace: CGFloat = 0.0
    var S_titleColor: UIColor?
    
    weak var shareScrollDelegate: DNShareScrollViewDelegate?
    
    deinit {
        print("deinit_scroll")
    }
    
    public func setShareArray(shareArray: Array<AnyObject>, delegate: AnyObject) {
        // 先移除之前的view
        if self.subviews.count > 0 {
            self.subviews.forEach({ (subview) in
                subview.removeFromSuperview()
            })
        }
        
        // 设置代理
        shareScrollDelegate = delegate as? DNShareScrollViewDelegate
        
        // 设置当前scrollview的contentSize
        if shareArray.count > 0 {
            //单行
            self.contentSize = CGSize(width: S_originX +  CGFloat(shareArray.count) * (S_icoWidth + S_horizontalSpace), height: self.frame.size.height)
        }
        
        // 遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
        for (index, value) in shareArray.enumerated() {
            let myframe = CGRect(x: S_originX + CGFloat(index) * (S_icoWidth + S_horizontalSpace), y: S_originY, width: S_icoWidth, height: S_icoWidth + S_icoAndTitleSpace+S_titleSize)
                let view = self.itemShareView(frame: myframe, dic: value as! Dictionary<String, String>, index: index)
            self.addSubview(view)
        }
        
    }
    
    public static func getShareScrollViewHeigt() -> CGFloat {
        let height = originY + icoWidth + icoAndTitleSpace + titleSize + lastlySpace
        return height
    }
    
    private func itemShareView(frame: CGRect, dic: Dictionary<String, String>, index: NSInteger) -> UIView {
        
        var image = dic["image"]
        let title = dic["title"] ?? ""
        
        let icoImage = UIImage(named: image!)!
        
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.clear
        
        let animationChangeHeight: CGFloat = 10
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (view.frame.size.width - icoImage.size.width) / 2, y: animationChangeHeight, width: icoImage.size.width, height: icoImage.size.height)
        button.titleLabel!.font = UIFont.systemFont(ofSize: titleSize)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.clear, for: .normal)
        if (image?.characters.count)! > 0 {
            button.setImage(UIImage(named: image!)!, for: .normal)
        }
        
        button.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        let label = UILabel(frame: CGRect(x: 0, y: button.frame.origin.y + button.frame.size.height + lastlySpace, width: view.frame.size.width, height: titleSize))
        label.textColor = titleColor
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: titleSize)
        label.text = title
        view.addSubview(label)
        
        UIView.animate(withDuration: 1, delay: (0.08 + 0.08 * Double(index)), usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {() -> Void in
            button.frame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y - animationChangeHeight, width: button.frame.size.width, height: button.frame.size.height)
            label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y - animationChangeHeight, width: label.frame.size.width, height: label.frame.size.height)
            }, completion: { _ in })

        return view
    }
    
    @objc private func buttonAction(sender: UIButton) {
        if (shareScrollDelegate != nil) {
            shareScrollDelegate?.shareScrollViewButtonAction(shareScrollView: self, title: (sender.titleLabel?.text!)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initScrollView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initScrollView(frame: CGRect) {
        self.showsHorizontalScrollIndicator = true
        self.showsVerticalScrollIndicator = true
        self.backgroundColor = UIColor.clear
        self.alwaysBounceHorizontal = true
        
        S_originX = originX
        S_originY = originY
        S_icoWidth = icoWidth
        S_icoAndTitleSpace = icoAndTitleSpace
        S_titleSize = titleSize
        S_titleColor = titleColor
        S_lastlySpace = lastlySpace
        S_horizontalSpace = horizontalSpace
        
        // 设置当前scrollview的高度
        if self.frame.size.height <= 0 {
            self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: S_originY + S_icoWidth + S_icoAndTitleSpace + S_titleSize + S_lastlySpace)
        } else {
            self.frame = frame;
        }
    }
    
}
