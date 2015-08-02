//
//  CellView.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/30/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

@IBDesignable
class CellView: UIView {

    let cellSize: Int = 2
    var model: CA?
    
    override func drawRect(rect: CGRect) {
        
        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        CGContextSetLineWidth(context, 0.05)

        // set up cellular automata
        var maxGens = Int(bounds.height) / cellSize
        var cellsPerGen = Int(bounds.width) / cellSize
        let ca = CA(numCells: cellsPerGen)
        
        // draw cellular automata
        for var generation = 0; generation < maxGens; generation++ {
            for var cellIndex = 0; cellIndex < ca.cells.count; cellIndex++ {
                getFillColor(ca.cells[cellIndex]).setFill()
                CGContextAddRect(context, CGRect(x: cellSize * cellIndex, y: ca.currentGen * cellSize, width: cellSize, height: cellSize))
                CGContextDrawPath(context, kCGPathFillStroke)
            }
            ca.generate()
        }
    }
  
    func getFillColor(cell:Cell) -> UIColor {
        return cell.isOn ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
    
    // MARK: OLD SHIT
    
    func oldDrawCells(cells: [Cell]) {
        let rows = Int(bounds.height) / cellSize
        let cols = Int(bounds.width) / cellSize
        
        var context = UIGraphicsGetCurrentContext()
        UIColor.blackColor().setStroke()
        
        for var row = 0; row < rows; row++ {
            for var col = 0; col < cols; col++ {
                
                var index = row*Int(bounds.width) + col
                getFillColor(cells[index]).setFill()
                CGContextAddRect(context, CGRect(x: cellSize * row, y: cellSize * col, width: cellSize, height: cellSize))
                CGContextDrawPath(context, kCGPathFillStroke)
            }
        }
    }
    
    
}
