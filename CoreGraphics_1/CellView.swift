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

    
    var automata: SingleGenCellularAutomata?
    var cellSize: Int = 10
    
    var maxGens: Int!
    var cellsPerGen: Int!
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        calcGenerations()
    }
    
    func calcGenerations() {
        maxGens = Int(bounds.height) / cellSize
        cellsPerGen = Int(bounds.width) / cellSize
    }
    
    override func drawRect(rect: CGRect) {
        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        CGContextSetLineWidth(context, 0.05)

        // calculate offset for centering graphics
        let centeringOffset = (Int(bounds.width) - (cellsPerGen * cellSize)) / 2
        
        // draw cellular automata
        if let automata = automata {
            for var generation = 0; generation < maxGens; generation++ {
                for var cellIndex = 0; cellIndex < automata.cells.count; cellIndex++ {
                    getFillColor(automata.cells[cellIndex]).setFill()
                    CGContextAddRect(context,
                        CGRect(x: cellSize * cellIndex + centeringOffset,
                               y: automata.numGenerations * cellSize,
                               width: cellSize,
                               height: cellSize)
                    )
                    CGContextDrawPath(context, kCGPathFillStroke)
                }
                automata.breed()
            }
        }
    }
  
    func getFillColor(cell:Cell) -> UIColor {
        return cell.isOn ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
}
