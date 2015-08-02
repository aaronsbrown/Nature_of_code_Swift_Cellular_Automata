//
//  PushButtonView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/29/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

@IBDesignable
class PushButtonView: UIButton {

    var fillColor: UIColor = UIColor.blackColor()
    var strokeColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {
        
        if !isAddButton {
            fillColor = UIColor.whiteColor()
            strokeColor = UIColor.blackColor()
        }
        
        fillColor.setFill()
        strokeColor.setStroke()
        
        var path = UIBezierPath(ovalInRect: rect)
        path.fill()
        if !isAddButton {
            path.lineWidth = 1.0
            path.stroke()
        }
        
        let strokeSize: CGFloat = 3.0
        let strokeLength: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        var plusPath = UIBezierPath()
        plusPath.lineWidth = strokeSize
        
        plusPath.moveToPoint(CGPoint(
            x: bounds.width/2 - strokeLength/2,
            y: bounds.height/2 ))
        
        plusPath.addLineToPoint(CGPoint(
            x: bounds.width/2+strokeLength/2,
            y: bounds.height/2))
        
        
        if isAddButton {
            plusPath.moveToPoint(CGPoint(
                x: bounds.width/2,
                y: bounds.height/2 + strokeLength/2))
            
            plusPath.addLineToPoint(CGPoint(
                x: bounds.width/2,
                y: bounds.height/2 - strokeLength/2))
        }
        
        plusPath.stroke()
        

    }
}
