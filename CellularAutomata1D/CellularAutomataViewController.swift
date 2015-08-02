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
    
    var automata: SingleGenCellularAutomata? {
        didSet {
            cellView?.automata = automata
        }
    }
    var ruleNumber: Int = 1

    override func viewDidLoad() {
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: 0)
        cellView.automata = automata

        label.text = "Rule No: \(ruleNumber)"
        sliderLabel.text = "cell size \(cellView.cellSize)"
    }

    @IBAction
    func incrementRule(sender: PushButtonView) {
        if ruleNumber >= automata?.ruleSet.maxRuleNum { 
            ruleNumber = 0
        } else {
            ruleNumber++
        }
        
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        if ruleNumber <= 0 {
            ruleNumber = automata!.ruleSet.maxRuleNum
        } else {
            ruleNumber--
        }
        
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        
        
        cellView.cellSize = Int(sender.value)
        cellView.calcGenerations()
        
        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)
        
        sliderLabel.text = "cell size: \(cellView.cellSize)"
        
    }
    
    @IBAction
    func generate(sender: UIButton) {
        ruleNumber = Int(arc4random_uniform(256))

        automata = SingleGenCellularAutomata(numCells: cellView.cellsPerGen, ruleNumber: ruleNumber)

        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet!.rules)"
    }

}

