//
//  CellViewDataSource.swift
//  CellularAutomata1D
//
//  Created by Aaron Brown on 8/4/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

protocol CellViewDataSource: class {
    
    func cells(sender: CellView) -> [Cell]?
    func currentRowIndex(sender: CellView) -> Int?
    
}