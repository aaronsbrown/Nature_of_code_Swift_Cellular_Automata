//
//  Cell.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 8/1/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

struct Cell: Printable {
    
    var value: Int
    var isOn: Bool {
        get {
            return value > 0
        }
    }
    var description: String {
        get {
            return String(value)
        }
    }
    
    init(value: Int) {
        self.value = value
    }
}

