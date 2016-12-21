//
//  UIViewExtension.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

// MARK: Frame
extension UIView {
    
    // x
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    // y
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    // width
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    // height
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    // left
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    // right
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }
    
    // top
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    // bottom
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }
    
    // origin
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    // centerX
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    // centerY
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    // size
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    // leftOffset
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    // rightOffset
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    // topOffset
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    // bottomOffset
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    // alignRight
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }
    
    // 移除子视图
    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

// MARK: Transform
extension UIView {
    // 以X轴旋转
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }
    
    // 以Y轴旋转
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }
    
    // 以Z轴旋转
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    // 旋转
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    // 放大比例
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: Layer
extension UIView {
    
    // 设置圆角
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // 添加阴影
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    // 加边框
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    // 添加上边框
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    // 添加上边框 可设置两头空缺
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    
    // 添加下边框
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    
    // 添加左边框
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    // 添加右边框
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    // 添加边界
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    // 画圆 圆填充+边框颜色 + 边框宽度
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    // 画圆 边框颜色 + 边框宽度
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}


private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

// MARK: Animation
extension UIView {
    
    // 执行弹性动画
    public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    // 执行弹性动画
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    // pop效果 size:放大比例 1...
    public func pop(size: CGFloat) {
        setScale(x: size, y: size)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    
    // 反向pop size: 0...1
    public func reversePop(size: CGFloat) {
        setScale(x: size, y: size)
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self] Void in
            self?.setScale(x: 1, y: 1)
        }) { (bool) in }
    }

}

// 渲染
extension UIView {
    // View转换成Image
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// 手势 Block是用是[weak self] (gesture), 可能造成的内存泄漏
extension UIView {
    
    // 添加点击手势 可设置点击次数
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    // 添加点击手势 Block回调
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> ())?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    // 添加滑动手势
    public func addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        #if os(iOS)
            swipe.numberOfTouchesRequired = numberOfTouches
        #endif
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    
    // 添加滑动手势 Block回调
    public func addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, action: ((UISwipeGestureRecognizer) -> ())?) {
        let swipe = BlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    
    // 添加拖拽手势
    public func addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    
    // 添加拖拽手势 Block回调
    public func addPanGesture(action: ((UIPanGestureRecognizer) -> ())?) {
        let pan = BlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    
     #if os(iOS)
    // 添加捏合手势
    public func addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    #endif
    
    #if os(iOS)
    // 添加捏合手势 Block回调
    public func addPinchGesture(action: ((UIPinchGestureRecognizer) -> ())?) {
        let pinch = BlockPinch(action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    #endif
    
    // 添加长按手势
    public func addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
    
    // 添加长按手势 Block回调
    public func addLongPressGesture(action: ((UILongPressGestureRecognizer) -> ())?) {
        let longPress = BlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}

extension UIView {
    // 画圆角 [.bottomLeft, .topRight]
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    // 视图变圆
    public func roundView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
}

extension UIView {
    // 循环查找rootView
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
}

private let UIViewDefaultFadeDuration: TimeInterval = 0.4
extension UIView {
    // 视图淡入 持续时间+延时+Block回调
    public func fadeIn(_ duration:TimeInterval? = UIViewDefaultFadeDuration, delay _delay:TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: _delay ?? 0.0, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            self.alpha = 1.0
        }, completion:completion)
    }
    
    // 视图淡入 持续时间+延时+Block回调
    public func fadeOut(_ duration:TimeInterval? = UIViewDefaultFadeDuration, delay _delay:TimeInterval? = 0.0, completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: _delay ?? 0.0, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            self.alpha = 0.0
        }, completion:completion)
    }
    
    // 视图淡化 alpha = Value
    public func fadeTo(_ value:CGFloat, duration _duration:TimeInterval? = UIViewDefaultFadeDuration, delay _delay:TimeInterval? = 0.0, completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: _duration ?? UIViewDefaultFadeDuration, delay: _delay ?? UIViewDefaultFadeDuration, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            self.alpha = value
        }, completion:completion)
    }
}

