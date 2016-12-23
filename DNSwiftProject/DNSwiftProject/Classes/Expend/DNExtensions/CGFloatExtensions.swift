//
//  CGFloatExtensions.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/20.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

extension CGFloat {
     public var center: CGFloat { return (self / 2) }
    
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    public mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }
    
    public static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    public func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    public mutating func toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }
    
    public static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }
    
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    public static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle = angle - twoPi
        }
        if angle <= -.pi {
            angle = angle + twoPi
        }
        return angle
    }
}
