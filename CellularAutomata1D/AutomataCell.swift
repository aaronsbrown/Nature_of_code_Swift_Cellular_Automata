//
//  CollectionCell.swift
//  CellularAutomata1D
//
//  Created by Aaron Brown on 8/10/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class AutomataCell : UICollectionViewCell, CellViewDataSource {
    
    
    @IBOutlet weak var cellView: CellView! {
        didSet {
            cellView.dataSource = self
        }
    }
    
    var automata: SingleGenCellularAutomata!
    
    // MARK: CellViewDataSource
    
    func cells(sender: CellView) -> [Cell] {
        return automata.cells
    }
    
    func currentRowIndex(sender: CellView) -> Int {
        return automata.numGenerationsBred
    }

}