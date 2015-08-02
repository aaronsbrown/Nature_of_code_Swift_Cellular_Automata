//
//  CA.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//
import Foundation

class SingleGenCellularAutomata {
    
    var ruleSet: RuleSet!
    
    var cells = [Cell]()
    var numGenerations = 0

    init(numCells: Int, ruleNumber: Int) {
        
        for i in 0 ..< numCells {
            cells.append(Cell(value: 0))
        }
        cells[cells.count / 2] = Cell(value: 1)
        
        ruleSet = RuleSet.forRuleNumber(ruleNumber)
    }
    
    convenience init(numCells: Int) {
        self.init(numCells: numCells, ruleNumber: 0)
    }
    
    func randomize() {
        ruleSet = RuleSet.random()
    }
    
    func breed() {
        
        var nextGen = [Cell](count: cells.count, repeatedValue: Cell(value: 0))
   
        for var i = 0; i < cells.count; i++ {
            
            switch(i) {
            case 0:
                nextGen[i] = calculateCellState(cells[cells.count - 1], current: cells[i], next: cells[i+1])
            case cells.count - 1:
                nextGen[i] = calculateCellState(cells[i-1], current: cells[i], next: cells[0])
            default:
                nextGen[i] = calculateCellState(cells[i-1], current: cells[i], next: cells[i+1])
            }
        }
        
        cells = nextGen
        numGenerations++
    }
    
    func calculateCellState(prev: Cell, current: Cell, next: Cell) -> Cell {
        
        // all random values
        // return Cell(value: Int(arc4random_uniform(2)))
        
        let cellContext = prev.description + current.description + next.description
        let ruleIndex = Int(strtoul(cellContext, nil, 2)) // convert from binary to decimal
        let value = ruleSet.rules.reverse()[ruleIndex]
        return  Cell(value: value)
    }
}