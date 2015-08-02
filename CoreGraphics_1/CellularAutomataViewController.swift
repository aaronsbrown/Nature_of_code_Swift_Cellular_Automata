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
   
    override func viewDidLoad() {
    }

    @IBAction func generate(sender: UIButton) {
        cellView.setNeedsDisplay()
        if (cellView.model != nil) {
            label.text = cellView.model?.currentRuleSet
        }
    }

}

