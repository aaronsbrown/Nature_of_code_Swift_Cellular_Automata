//
//  FrameBasedAnimationViewController.swift
//  CellularAutomata1D
//
//  Created by Aaron Brown on 8/8/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    let drawTimeInterval:CFTimeInterval = 1/30
    
    var displayLink: CADisplayLink!
    var prevTimestamp: CFTimeInterval = 0
    var timeSinceLastDisplayUpdate: CFTimeInterval = 0
    var timeSinceLastFrameDraw: CFTimeInterval = 0.0

    var animationRunning:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: "updateDisplayLink:")
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        animationRunning = true
    }
    
    func updateDisplayLink(sender: CADisplayLink) {
        
        if prevTimestamp == 0 {
            prevTimestamp = displayLink.timestamp
            return
        }
        
        let currentTime = displayLink.timestamp
        timeSinceLastDisplayUpdate = currentTime - prevTimestamp
        prevTimestamp = currentTime
        
        if timeSinceLastFrameDraw > drawTimeInterval {
            drawFrame(timeSinceLastDisplayUpdate)
        }
        timeSinceLastFrameDraw += timeSinceLastDisplayUpdate
        
    }
    
    // Subclasses should override this
    func drawFrame(timeSinceLastDisplayUpdate: CFTimeInterval) {
        timeSinceLastFrameDraw = 0
    }
    
    func pauseAnimation() {
        displayLink.paused = !displayLink.paused
    }
}
