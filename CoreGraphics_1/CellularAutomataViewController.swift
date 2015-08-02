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

    
    override func viewDidLoad() {
        label.text = "Rule No: \(cellView.ruleNumber)"
        sliderLabel.text = "\(cellView.cellSize)"
    }

    
    @IBAction
    func incrementRule(sender: PushButtonView) {
        cellView.incrementRuleNumber()
        label.text = "Rule No: \(cellView.ruleNumber) \(cellView.automata!.ruleSet!.rules)"
        cellView.setNeedsDisplay()
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        cellView.decrementRuleNumber()
        label.text = "Rule No: \(cellView.ruleNumber) \(cellView.automata!.ruleSet!.rules)"
        cellView.setNeedsDisplay()
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        cellView.cellSize = Int(sender.value)
        sliderLabel.text = "\(cellView.cellSize)"
        cellView.setNeedsDisplay()

    }
    
    @IBAction
    func generate(sender: UIButton) {
        cellView.randomize()
        label.text = "Wolfram Rule No: \(cellView.ruleNumber)"
        cellView.setNeedsDisplay()
    }

}

