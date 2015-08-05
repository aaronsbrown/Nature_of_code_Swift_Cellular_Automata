//
//  ViewController.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/29/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellularAutomataViewController: UIViewController, CellViewDataSource, DisplayLinkerDelegate {

    @IBOutlet weak var cellView: CellView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    
    var displayLinker: DisplayLinker?
    var elapsedFrameRate: CFTimeInterval = 0.0
    
    var automata: SingleGenCellularAutomata?
    var ruleNumber: Int = 90

    
    // MARK: initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLinker = DisplayLinker(delegate: self)
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)
        
        cellView.dataSource = self
        
        label.text = "Rule No: \(ruleNumber)"
        sliderLabel.text = "cell size \(cellView.cellSize)"
    }

    
    // MARK: User Interaction
    @IBAction
    func incrementRule(sender: PushButtonView) {
        if ruleNumber >= automata?.ruleSet.maxRuleNum { 
            ruleNumber = 0
        } else {
            ruleNumber++
        }
        
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)
        
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        if ruleNumber <= 0 {
            ruleNumber = automata!.ruleSet.maxRuleNum
        } else {
            ruleNumber--
        }
        
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)
        
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        
        
        cellView.cellSize = Int(sender.value)
       
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)

        sliderLabel.text = "cell size: \(cellView.cellSize)"
        
    }
    
    @IBAction func generate(sender: UIButton) {
        ruleNumber = Int(arc4random_uniform(256))

        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)

        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }
    
    
    // MARK: CellViewDataSource
    func cells() -> [Cell] {
        if let automata = automata {
            return automata.cells
        } else {
            return [Cell]()
        }
    }
    
    func currentRowIndex() -> Int {
        if let automata = automata {
            return automata.numGenerations
        } else {
            return 0
        }
    }
    

    // MARK: DisplayLinkerDelegate
    func updateDisplay(deltaTime: CFTimeInterval) {
        
        elapsedFrameRate += deltaTime
        if elapsedFrameRate > 1/30 {
            cellView.setNeedsDisplay()
            automata?.breed()
            elapsedFrameRate = 0
        }
    }

}

