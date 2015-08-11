//
//  CellView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/30/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellView: UICollectionViewCell {

    weak var dataSource: CellViewDataSource?

    var cellSize: Int = 10 {
        didSet { calculateRowsAndCols() }
    }
    
    var rows: Int!
    var cols: Int!
    
    func calculateRowsAndCols() {
        rows = Int(bounds.height) / cellSize
        cols = Int(bounds.width) / cellSize
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        println("willMove")
        calculateRowsAndCols()
    }
    
    override func drawRect(rect: CGRect) {
        
        println("drawRect")
        
        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        UIColor.darkGrayColor().setFill()
        CGContextSetLineWidth(context, 0.05)

        // calculate offset for centering graphics
        let centeringOffset = (Int(bounds.width) - (cols * cellSize)) / 2
        
        // drawGrid
        for var row = 0; row < rows; row++ {
            for var col = 0; col < cols; col++ {
                CGContextAddRect(context,
                    CGRect(
                        x: cellSize * col + centeringOffset,
                        y: row * cellSize,
                        width: cellSize,
                        height: cellSize))
                CGContextDrawPath(context, kCGPathStroke)
            }
        }
       
        // draw cellular automata
        let cells = dataSource?.cells(self) ?? [Cell]()
        let numRowsToDraw = dataSource?.currentRowIndex(self) ?? 0
        
        for var row = 0; row < numRowsToDraw; row++ {
            for var col = 0; col < cols; col++ {
                let cellValue = cells[col].values[row]
                if cellValue > 0 {
                    CGContextAddRect(context,
                        CGRect(
                            x: cellSize * col + centeringOffset,
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
