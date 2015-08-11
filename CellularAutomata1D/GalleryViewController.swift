//
//  GalleryViewController.swift
//  CellularAutomata1D
//
//  Created by Aaron Brown on 8/10/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//     MARK: CollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RuleSet().maxRuleNum
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AutomataCell", forIndexPath: indexPath) as! AutomataCell
        
        println(cell.cellView.bounds.width)
        println(cell.cellView.bounds.height)
        
        cell.cellView.cellSize = 5
        cell.cellView.calculateRowsAndCols()

        var numCols = cell.cellView.cols
        var numRows = cell.cellView.rows
        println(numCols)
        println(numRows)
        
        
        cell.automata = SingleGenCellularAutomata(numCells: numCols, ruleNumber: indexPath.indexAtPosition(1))
        cell.automata.breed(numRows)
        cell.cellView.setNeedsDisplay()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("selected item: \(indexPath)")
    }

}
