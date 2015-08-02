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

    let cellSize: Int = 1
    var model: CellularAutomata!
    var ruleNumber: Int = 0
    
    override func drawRect(rect: CGRect) {
        
        // set up graphics context
        var context = UIGraphicsGetCurrentContext()
        UIColor.darkGrayColor().setStroke()
        CGContextSetLineWidth(context, 0.05)

        // set up cellular automata
        var maxGens = Int(bounds.height) / cellSize
        var cellsPerGen = Int(bounds.width) / cellSize
        var model = CellularAutomata(numCells: cellsPerGen, ruleNumber: ruleNumber)
        println(model.currentRuleSet)
        
        // draw cellular automata
        for var generation = 0; generation < maxGens; generation++ {
            for var cellIndex = 0; cellIndex < model.cells.count; cellIndex++ {
                getFillColor(model.cells[cellIndex]).setFill()
                CGContextAddRect(context, CGRect(x: cellSize * cellIndex, y: model.currentGen * cellSize, width: cellSize, height: cellSize))
                CGContextDrawPath(context, kCGPathFillStroke)
            }
            model.generate()
        }
        
    }
  
    func incrementRuleNumber() {
        if ruleNumber >= 255 {
            ruleNumber = 0
        } else {
            ruleNumber++
        }
    }
    
    func decrementRuleNumber() {
        if ruleNumber <= 0 {
            ruleNumber = 255
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
