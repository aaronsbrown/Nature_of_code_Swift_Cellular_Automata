//
//  ViewController.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/29/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellularAutomataViewController: AnimationViewController, CellViewDataSource {

    // MARK: UI
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!

    @IBOutlet weak var cellView: CellView! {
        didSet {
            cellView.dataSource = self
        }
    }
    
    // MARK: Model
    
    var automata: SingleGenCellularAutomata!
    var ruleNumber: Int = 90
    var numCellsDrawn = 0
    var maxGenerationsToDraw = 0
    
  
    // MARK: Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Rule No: \(ruleNumber)"
        sliderLabel.text = "cell size \(cellView.cellSize)"
        initAnimation(ruleNumber)
    }

   override func drawFrame(timeSinceLastDisplayUpdate: CFTimeInterval) {
        super.drawFrame(timeSinceLastDisplayUpdate)
        if numCellsDrawn < maxGenerationsToDraw {
            automata.breed()
            numCellsDrawn = automata.numGenerations
            cellView.setNeedsDisplay()
        }
    
    }
    
    private func initAnimation(ruleNumber:Int) {
        numCellsDrawn = 0
        maxGenerationsToDraw = cellView.rows
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)
    }
    
    @IBAction func pause(sender: AnyObject) {
        super.pauseAnimation()
    }
    
    @IBAction func incrementRule(sender: PushButtonView) {
        ruleNumber = automata.ruleSet.nextRuleNum(ruleNumber)
        label.text = "Rule No: \(ruleNumber) \(automata.ruleSet.rules)"
        initAnimation(ruleNumber)
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        ruleNumber = automata.ruleSet.prevRuleNum(ruleNumber)
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet.rules)"
        initAnimation(ruleNumber)
    }
    
    @IBAction func randomRuleSet(sender: UIButton) {
        ruleNumber = automata.ruleSet!.randomRuleNum()
        label.text = "Rule No: \(ruleNumber) \(automata.ruleSet.rules)"
        initAnimation(ruleNumber)
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        cellView.cellSize = Int(sender.value)
        sliderLabel.text = "cell size: \(cellView.cellSize)"
        initAnimation(ruleNumber)
    }
    
    // MARK: CellViewDataSource
    
    func cells(sender: CellView) -> [Cell] {
        return automata.cells
    }
    
    func currentRowIndex(sender: CellView) -> Int {
        return automata.numGenerations
    }
}

