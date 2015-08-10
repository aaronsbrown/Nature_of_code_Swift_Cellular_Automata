//
//  ViewController.swift
//  CoreGraphics_1
//
//  Created by Aaron Brown on 7/29/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

enum DisplayMode {
    case Animate
    case Static
}

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
    var numGenerationsDrawn = 0
    var maxGenerationsToDraw = 0
    
  
    // MARK: Controller
    var displayMode: DisplayMode = .Animate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Rule No: \(ruleNumber)"
        sliderLabel.text = "cell size \(cellView.cellSize)"
        initNewAutomata(ruleNumber)
    }

    private func initNewAutomata(ruleNumber:Int) {
        numGenerationsDrawn = 0
        maxGenerationsToDraw = cellView.rows
        automata = SingleGenCellularAutomata(numCells: cellView.cols, ruleNumber: ruleNumber)
    }

    override func drawFrame(timeSinceLastDisplayUpdate: CFTimeInterval) {
        super.drawFrame(timeSinceLastDisplayUpdate)
    
        if numGenerationsDrawn < maxGenerationsToDraw {
            switch displayMode {
                case .Animate:
                    automata.breed()
                    break
                case .Static:
                    automata.breed(cellView.rows)
                    break
            }
            numGenerationsDrawn = automata.numGenerationsBred
            cellView.setNeedsDisplay()
        }
    }
    
    @IBAction func animateDisplay(sender: AnyObject) {
        displayMode = .Animate
        super.startAnimation()
        initNewAutomata(ruleNumber)
    }
    
    @IBAction func staticDisplay(sender: AnyObject) {
        displayMode = .Static
        super.pauseAnimation()
    }
    
    @IBAction func pause(sender: AnyObject) {
        super.toggleAnimation()
    }
    
    @IBAction func incrementRule(sender: PushButtonView) {
        ruleNumber = automata.ruleSet.nextRuleNum(ruleNumber)
        label.text = "Rule No: \(ruleNumber) \(automata.ruleSet.rules)"
        initNewAutomata(ruleNumber)
    }
    
    @IBAction func decrementRule(sender: PushButtonView) {
        ruleNumber = automata.ruleSet.prevRuleNum(ruleNumber)
        label.text = "Rule No: \(ruleNumber) \(automata!.ruleSet.rules)"
        initNewAutomata(ruleNumber)
    }
    
    @IBAction func randomRuleSet(sender: UIButton) {
        ruleNumber = automata.ruleSet!.randomRuleNum()
        label.text = "Rule No: \(ruleNumber) \(automata.ruleSet.rules)"
        initNewAutomata(ruleNumber)
    }
    
    @IBAction func updateCellSize(sender: UISlider) {
        cellView.cellSize = Int(sender.value)
        sliderLabel.text = "cell size: \(cellView.cellSize)"
        initNewAutomata(ruleNumber)
    }
    
    // MARK: CellViewDataSource
    
    func cells(sender: CellView) -> [Cell] {
        return automata.cells
    }
    
    func currentRowIndex(sender: CellView) -> Int {
        return automata.numGenerationsBred
    }
}

