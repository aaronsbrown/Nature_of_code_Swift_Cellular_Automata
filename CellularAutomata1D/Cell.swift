//
//  Cell.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

class Cell {
    
    var value: Int
    var values = [Int]()
    
    init(value: Int) {
        self.value = value
//        values.append(value)
    }
    
    var isOn: Bool {
        get {
            return values.last > 0
        }
    }
   
    var prevValueString: String {
        get {
            return String(values[values.count - 1])
        }
    }
    
    
    func saveState() {
        values.append(value)
    }
}

