//
//  DNDragView.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

enum DNDragDirection {
    case any        // 任意
    case horizontal // 水平
    case vertical   // 垂直
}

class DNDragView: UIView, UIGestureRecognizerDelegate {
    
    public var onBeginDrageBlock: ((DNDragView) -> Void)?
    public var onDuringDrageBlock: ((DNDragView) -> Void)?
    public var onEndDrageBlock: ((DNDragView) -> Void)?
    public var onClickDrageBlock: ((DNDragView) -> Void)?
    
    // 能否拖拽 默认true(可以拖拽)
    public var isDragEnable: Bool?
    // 是不是保持在边界 默认false
    public var isKeepBounds: Bool?
    // 活动范围
    public var freeRect: CGRect?
    // 拖曳的方向，默认为any，任意方向
    public var dragDirection: DNDragDirection?

    fileprivate var startPoint: CGPoint?
    fileprivate var startFramePoint: CGPoint?
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer?
    
    // MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    // 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 方法
    func setUp() {
        self.isDragEnable = true
        self.clipsToBounds = true
        self.isKeepBounds = false
        self.dragDirection = .any
        self.freeRect = CGRect(origin: CGPoint.zero, size: CGSize(width: SCREEN_W, height: SCREEN_H))
        self.backgroundColor = UIColor.lightGray
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.clickDragView))
        self.addGestureRecognizer(singleTap)
        
        // 添加移动手势可以拖动
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.dragAction(_:)))
        panGestureRecognizer?.minimumNumberOfTouches = 1
        panGestureRecognizer?.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGestureRecognizer!)
    }
    
    // 拖动事件
    func dragAction(_ pan: UIPanGestureRecognizer) {
        guard isDragEnable! else { return }
        switch pan.state {
        case .began:
            if self.onBeginDrageBlock != nil {
                self.onBeginDrageBlock!(self)
            }
            pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
            self.startPoint = pan.translation(in: self)
            self.superview?.bringSubview(toFront: self)
            
        case .changed:
            if self.onDuringDrageBlock != nil {
                self.onDuringDrageBlock!(self)
            }
            let point = pan.translation(in: self)
            var dx: CGFloat?
            var dy: CGFloat?
            
            switch self.dragDirection! {
            case .any:
                dx = point.x - (self.startPoint?.x)!
                dy = point.y - (self.startPoint?.y)!
            case .horizontal:
                dx = point.x - (self.startPoint?.x)!;
                dy = 0;
            case .vertical:
                dx = point.x - (self.startPoint?.x)!;
                dy = point.y - (self.startPoint?.y)!;
            }
            
            let newCenter = CGPoint(x: self.center.x + dx!, y: self.center.y + dy!)
            self.center = newCenter
            pan.setTranslation(CGPoint(x: 0, y: 0), in: self)
        case .ended:
            self.keepBounds()
            if self.onEndDrageBlock != nil {
                self.onEndDrageBlock!(self)
            }
        default:
            print("tap其他状态")
        }
    }
    
    // 点击事件
    func clickDragView() {
        if self.onClickDrageBlock != nil {
            self.onClickDrageBlock!(self)
        }
    }
    
    func keepBounds() {
        
        let centerX = (self.freeRect?.origin.x)! + ((self.freeRect?.size.width)! - self.frame.size.width)/2
        var rect = self.frame
        if isKeepBounds == false {
            if self.frame.origin.x < (self.freeRect?.origin.x)! {
                UIView.beginAnimations("leftMove", context: nil)
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationDuration(0.5)
                rect.origin.x = (self.freeRect?.origin.x)!
                self.frame = rect
                UIView.commitAnimations()

            } else if (self.freeRect?.origin.x)!+(self.freeRect?.size.width)! < self.frame.origin.x+self.frame.size.width {
                UIView.beginAnimations("rightMove", context: nil)
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationDuration(0.5)
                rect.origin.x = (self.freeRect?.origin.x)! + (self.freeRect?.size.width)! - self.frame.size.width
                self.frame = rect
                UIView.commitAnimations()

            }
        } else {
            if self.frame.origin.x < centerX {
                UIView.beginAnimations("leftMove", context: nil)
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationDuration(0.5)
                rect.origin.x = (self.freeRect?.origin.x)!
                self.frame = rect
                UIView.commitAnimations()
            } else {
                UIView.beginAnimations("rightMove", context: nil)
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationDuration(0.5)
                rect.origin.x = (self.freeRect?.origin.x)! + (self.freeRect?.size.width)! - self.frame.size.width
                self.frame = rect
                UIView.commitAnimations()
            }
        }
        
        if self.frame.origin.y < (self.freeRect?.origin.y)! {
            UIView.beginAnimations("topMove", context: nil)
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationDuration(0.5)
            rect.origin.y = (self.freeRect?.origin.y)!
            self.frame = rect
            UIView.commitAnimations()
        } else if (self.freeRect?.origin.y)! + (self.freeRect?.size.height)! < self.frame.origin.y + self.frame.size.height {
            UIView.beginAnimations("bottomMove", context: nil)
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationDuration(0.5)
            rect.origin.y = (self.freeRect?.origin.y)! + (self.freeRect?.size.height)! - self.frame.size.height
            self.frame = rect
            UIView.commitAnimations()
        }
    }
    
    // MARK: setter&getter
    lazy var imageView: UIImageView = {
        let imageV = UIImageView(frame: CGRect(origin: CGPoint.zero, size: self.bounds.size))
        imageV.isUserInteractionEnabled = true
        imageV.clipsToBounds = true
        self.contentViewForDrag.addSubview(imageV)
        return imageV
    }()
    
    lazy var button: UIButton = {
        let bt = UIButton(frame: CGRect(origin: CGPoint.zero, size: self.bounds.size))
        bt.clipsToBounds = true
        bt.isEnabled = false
        self.contentViewForDrag.addSubview(bt)
        return bt
    }()

    lazy var contentViewForDrag: UIView = {
        let contentV = UIView(frame: CGRect(origin: CGPoint.zero, size: self.bounds.size))
        contentV.clipsToBounds = true
        self.addSubview(contentV)
        return contentV
    }()
}
