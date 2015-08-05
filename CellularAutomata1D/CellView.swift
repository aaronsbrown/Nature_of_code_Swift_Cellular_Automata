//
//  CellView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/30/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

//@IBDesignable
class CellView: UIView {

    // TODO if this changes, set needs display
    var cellSize: Int = 10 {
        didSet {
            calculateCellMatrix()
            setNeedsDisplay() // not doing much since generations not reset
        }
    }
    
    var rows: Int!
    var cols: Int!
    
    var dataSource: CellViewDataSource?
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        calculateCellMatrix()
    }
    
    func calculateCellMatrix() {
        rows = Int(bounds.height) / cellSize
        cols = Int(bounds.width) / cellSize
    }
    
    override func drawRect(rect: CGRect) {

        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        CGContextSetLineWidth(context, 0.05)

        // calculate offset for centering graphics
        let centeringOffset = (Int(bounds.width) - (cols * cellSize)) / 2
        
        // draw cellular automata
        let cells = dataSource!.cells()
        
//            for var generation = 0; generation < maxGens; generation++ {
                for var cellIndex = 0; cellIndex < cells.count; cellIndex++ {
                    getFillColor(cells[cellIndex]).setFill()
                    CGContextAddRect(context,
                        CGRect(x: cellSize * cellIndex + centeringOffset,
                               y: dataSource!.currentRowIndex() * cellSize,
                               width: cellSize,
                               height: cellSize)
                    )
                    CGContextDrawPath(context, kCGPathFillStroke)
                }
//            }
      
    }
  
    func getFillColor(cell:Cell) -> UIColor {
        return cell.isOn ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
}
