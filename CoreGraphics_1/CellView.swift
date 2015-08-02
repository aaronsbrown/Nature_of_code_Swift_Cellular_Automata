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
    var cellSize: Int = 4
    var ruleNumber: Int = 30
    
    
    override func drawRect(rect: CGRect) {
        
        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        CGContextSetLineWidth(context, 0.05)

        // set up cellular automata
        var maxGens = Int(bounds.height) / cellSize
        var cellsPerGen = Int(bounds.width) / cellSize
        automata = SingleGenCellularAutomata(numCells: cellsPerGen, ruleNumber: ruleNumber)

        // draw cellular automata
        if let automata = automata {
            for var generation = 0; generation < maxGens; generation++ {
                for var cellIndex = 0; cellIndex < automata.cells.count; cellIndex++ {
                    getFillColor(automata.cells[cellIndex]).setFill()
                    CGContextAddRect(context, CGRect(x: cellSize * cellIndex, y: automata.numGenerations * cellSize, width: cellSize, height: cellSize))
                    CGContextDrawPath(context, kCGPathFillStroke)
                }
                automata.breed()
            }
        }
        
    }
  
    // TODO these numbers
    func incrementRuleNumber() {
        if ruleNumber >= automata?.ruleSet.maxRuleNum {
            ruleNumber = 0
        } else {
            ruleNumber++
        }
    }
    
    func decrementRuleNumber() {
        if ruleNumber <= 0 {
            ruleNumber = automata!.ruleSet.maxRuleNum
        } else {
            ruleNumber--
        }
    }
    
    func randomize() {
        ruleNumber = Int(arc4random_uniform(256))
    }
    
    func getFillColor(cell:Cell) -> UIColor {
        return cell.isOn ? UIColor.darkGrayColor() : UIColor.whiteColor()
    }
}
