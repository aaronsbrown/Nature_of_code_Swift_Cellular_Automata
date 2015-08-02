//
//  RuleSet.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import Darwin

struct RuleSet {

    let neighborhoodSize = 3 // me and my two neighbors!
    let numStates = 2 // i'm off or i'm on!
    
    var rules = [Int]()
    
    var numRules: Int {
        get { return Int(pow(Double(numStates), Double(neighborhoodSize))) }
    }
    
    var maxRuleNum: Int {
        get { return Int(pow(Double(numStates), Double(numRules))) - 1 }
    }
    
    /**
     * Returns a string representation of base-10 Rule Number for this RuleSet
     */
    var ruleNumber: String {
        var binaryString = ""
        for rule in rules {
            binaryString += "\(rule)"
        }
        return String(Int(strtoul(binaryString, nil, 2)))
    }

    /** 
     * Returns a RuleSet for a specified ruleNumber. ruleNUmber is 
     * clamped to this RuleSets maxRuleNumber
     */
    static func forRuleNumber(var ruleNumber: Int) -> RuleSet {
        var ruleSet = RuleSet()
        
        if ruleNumber > ruleSet.maxRuleNum {
            ruleNumber = ruleSet.maxRuleNum
        }
        
        var bitArray = Array(String(ruleNumber, radix: 2))
        // create an array of binary numbers based on rule number
        // and ensure we have enough rules to satisfy 'numRules'
        ruleSet.rules =
            Array(count: max(0, ruleSet.numRules - bitArray.count), repeatedValue:0) +
            bitArray.map { String($0).toInt()! }

        return ruleSet
    }

    /**
     * Returns a RuleSet for a random ruleNumber
     */
    static func random() -> RuleSet {
        var ruleSet = RuleSet()
        for var i = 0; i < ruleSet.numRules; i++ {
            ruleSet.rules.append( Int(arc4random_uniform(2)) )
        }
        return ruleSet
    }
    
}

