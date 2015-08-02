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

    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    
    
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
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
        
        UIColor.whiteColor().setStroke()
        plusPath.stroke()

        
    }
}
