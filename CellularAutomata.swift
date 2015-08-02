//
//  CA.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//


import Foundation

struct RuleSet {
    var rules = [Int]()
    
    static func random() -> RuleSet {
        var ruleSet = RuleSet()
        for var i = 0; i < 8; i++ {
            ruleSet.rules.append( Int(arc4random_uniform(2)) )
        }
        return ruleSet
    }
    
    static func forRuleNumber(ruleNumber: Int) -> RuleSet {
        var ruleSet = RuleSet()
        
        var bitArray = Array(String(ruleNumber, radix: 2))
        ruleSet.rules =
            Array(count: max(0, 8 - bitArray.count), repeatedValue:0) +
            bitArray.map { String($0).toInt()! }
        return ruleSet
    }
    
    var ruleNumber: String {
        var binaryString = ""
        for rule in rules {
            binaryString += "\(rule)"
        }
        return String(Int(strtoul(binaryString, nil, 2)))
    }
}

class CellularAutomata {
    
    var ruleSet = RuleSet.random()
    var currentRuleSet: String {
        get { return ruleSet.ruleNumber }
    }
    
    var cells = [Cell]()
    var currentGen = 0

    init(numCells: Int, ruleNumber: Int) {
        
        for i in 0 ..< numCells {
            cells.append(Cell(value: 0))
        }
        cells[cells.count / 2] = Cell(value: 1)
        
        ruleSet = RuleSet.forRuleNumber(ruleNumber)
        
    }
    
    func randomize() {
        ruleSet = RuleSet.random()
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
        let value = ruleSet.rules[ruleIndex]
        return  Cell(value: value)
    }
}