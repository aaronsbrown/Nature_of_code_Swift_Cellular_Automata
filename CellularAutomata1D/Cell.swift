//
//  Cell.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

class Cell {
    
    var value: Int
    var prevValue: Int
    
    init(value: Int) {
        self.value = value
        self.prevValue = value
    }
    
    var isOn: Bool {
        get {
            return value > 0
        }
    }
   
    var prevValueString: String {
        get {
            return String(prevValue)
        }
    }
    
    func saveState() {
        prevValue = value
    }
}

