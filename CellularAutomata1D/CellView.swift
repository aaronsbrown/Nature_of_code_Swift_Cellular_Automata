//
//  CellView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/30/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellView: UIView {

    var dataSource: CellViewDataSource?

    var cellSize: Int = 10 {
        didSet {
            calculateRowsAndCols()
            setNeedsDisplay() // not doing much since generations not reset
        }
    }
    
    var rows: Int!
    var cols: Int!
    
    func calculateRowsAndCols() {
        rows = Int(bounds.height) / cellSize
        cols = Int(bounds.width) / cellSize
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        calculateRowsAndCols()
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
        let currentRow = dataSource!.currentRowIndex()
        
        if currentRow <= rows {
            for var col = 0; col < cols; col++ {
                getFillColor(cells[col]).setFill()
                CGContextAddRect(context,
                    CGRect(x: cellSize * col + centeringOffset,
                           y: currentRow * cellSize,
                           width: cellSize,
                           height: cellSize)
                )
                CGContextDrawPath(context, kCGPathFillStroke)
            }
        }
    }
  
    func getFillColor(cell:Cell) -> UIColor {
        return cell.isOn ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
}
