//
//  CellView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/30/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellView: UIView {

    weak var dataSource: CellViewDataSource?

    var cellSize: Int = 10 {
        didSet {
            calculateRowsAndCols()
            setNeedsDisplay()
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
        let cells = dataSource?.cells(self) ?? [Cell]()
        let currentRow = dataSource?.currentRowIndex(self) ?? 0
        
        if currentRow <= rows && cells.first!.values.count > 0 {
            
            for var row = 0; row < currentRow; row++ {
                for var col = 0; col < cols; col++ {
                    if cells[col].values.count > row {
                    getFillColor(cells[col].values[row]).setFill()
                    CGContextAddRect(context,
                        CGRect(x: cellSize * col + centeringOffset,
                               y: row * cellSize,
                               width: cellSize,
                               height: cellSize)
                    )
                    CGContextDrawPath(context, kCGPathFillStroke)
                    }
                }
            }
        }
    }
  
    func getFillColor(value:Int) -> UIColor {
        return value > 0 ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
}
