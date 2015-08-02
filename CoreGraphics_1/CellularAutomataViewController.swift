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
   
    @IBAction
    func incrementRule(sender: PushButtonView) {
        cellView.incrementRuleNumber()
        label.text = "Wolfram Rule No: \(cellView.ruleNumber)"
        cellView.setNeedsDisplay()
    }
    
    @IBAction func DecrementRule(sender: PushButtonView) {
        cellView.decrementRuleNumber()
        label.text = "Wolfram Rule No: \(cellView.ruleNumber)"
        cellView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        label.text = "Wolfram Rule No: \(cellView.ruleNumber)"
    }

    @IBAction
    func generate(sender: UIButton) {
        cellView.randomize()
        label.text = "Wolfram Rule No: \(cellView.ruleNumber)"
        cellView.setNeedsDisplay()
    }

}

