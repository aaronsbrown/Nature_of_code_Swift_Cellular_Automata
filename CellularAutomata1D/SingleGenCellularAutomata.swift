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
    var maxGenerations = 0

    init(numCells: Int, maxGenerations: Int, ruleNumber: Int) {
        
        for i in 0 ..< numCells {
            cells.append(Cell(value: 0))
        }
        cells[cells.count / 2] = Cell(value: 1)
        self.maxGenerations = maxGenerations
        
        ruleSet = RuleSet.forRuleNumber(ruleNumber)
    }
    
    convenience init(numCells: Int, maxGenerations: Int) {
        self.init(numCells: numCells, maxGenerations: maxGenerations, ruleNumber: 0)
    }
    
    func randomRuleSet() {
        ruleSet = RuleSet.random()
    }
    
    
    func breed(numGenerations: Int) {
        for i in 0 ..< numGenerations {
          self.breed()
        }

    }
    
    func breed() {
        
        for cell in cells {
            cell.saveState()
        }
        
        for var i = 0; i < cells.count; i++ {

            var prevIndex = i == 0 ? cells.count - 1 : i - 1
            var nextIndex = i == cells.count - 1 ? 0 : i + 1

            var cell = cells[i]
            cell.value = calculateCellState(cells[prevIndex], current: cell, next: cells[nextIndex])
        }
        
        numGenerations++
    }
    
    
    func calculateCellState(prev: Cell, current: Cell, next: Cell) -> Int {
        let binaryString = prev.prevValueString + current.prevValueString + next.prevValueString
        let ruleIndex = Int(strtoul(binaryString, nil, 2))
        return ruleSet.rules.reverse()[ruleIndex]
    }
}