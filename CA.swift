//
//  CA.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import Darwin

class CA {
    
    let neighborhoodSize = 3
    var ruleSet = [0, 1, 0, 1, 1, 0, 1, 0].reverse()
    var currentRuleSet = ""
    
    var cells = [Cell]()
    var currentGen = 0

   
    
    init(numCells: Int) {
        for i in 0 ..< numCells {
            cells.append(Cell(value: 0))
        }
        cells[cells.count / 2] = Cell(value: 1)
        randomRuleSet()
        
        var binaryString = ""
        for rule in ruleSet {
            binaryString += String(rule)
        }
        
        self.currentRuleSet = String(Int(strtoul(binaryString, nil, 2)))
    }
    
    func randomRuleSet() {
        for var i = 0; i < 8; i++ {
            ruleSet[i] = Int(arc4random_uniform(2))
        }
    }
    
    
    func generate() {
        
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
        currentGen++
    }
    
    func calculateCellState(prev: Cell, current: Cell, next: Cell) -> Cell {
        
        // all random values
        // return Cell(value: Int(arc4random_uniform(2)))
        
        let cellContext = prev.description + current.description + next.description
        let ruleIndex = Int(strtoul(cellContext, nil, 2))
        let value = ruleSet[ruleIndex]
        return  Cell(value: value)
    }
}