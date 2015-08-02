//
//  ViewController.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/29/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class CellularAutomataViewController: UIViewController {

    @IBOutlet weak var cellView: CellView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    
    var automata: SingleGenCellularAutomata?
    var ruleNumber: Int = 1

    
    override func viewDidLoad() {
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: 0)
        label.text = "Rule No: \(ruleNumber)"
        sliderLabel.text = "\(cellView.cellSize)"
        cellView.automata = automata
    }

    
    @IBAction
    func incrementRule(sender: PushButtonView) {
        if ruleNumber >= automata?.ruleSet.maxRuleNum { 
            ruleNumber = 0
        } else {
            ruleNumber++
        }
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        cellView.automata = automata
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
        cellView.setNeedsDisplay()
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        if ruleNumber <= 0 {
            ruleNumber = automata!.ruleSet.maxRuleNum
        } else {
            ruleNumber--
        }
        
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        cellView.automata = automata
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
        cellView.setNeedsDisplay()
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        
        sliderLabel.text = "\(cellView.cellSize)"
        cellView.cellSize = Int(sender.value)

        cellView.calcGenerations()
        cellView.automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        
        cellView.setNeedsDisplay()
        

    }
    
    @IBAction
    func generate(sender: UIButton) {
        ruleNumber = Int(arc4random_uniform(256))
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        cellView.automata = automata
        label.text = "Wolfram Rule No: \(ruleNumber)"
        cellView.setNeedsDisplay()
    }

}

