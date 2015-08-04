
//
//  DisplayLinker.swift
//  CellularAutomata1D
//
//  Created by Aaron Brown on 8/3/15.
//  Copyright (c) 2015 Aaron Brown. All rights reserved.
//

import Foundation
import QuartzCore


class DisplayLinker: NSObject {
    
    var delegate: DisplayLinkerDelegate
    var displayLink: CADisplayLink?
    var nextDeltaTimeZero: Bool = true
    var previousTimestamp: CFTimeInterval = 0.0
    
    init(delegate: DisplayLinkerDelegate) {
        self.delegate = delegate
        super.init()
        ensureDisplayLinkIsOnRunLoop()
    }
    
    func ensureDisplayLinkIsOnRunLoop() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: Selector("displayLinkUpdated"))
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            nextDeltaTimeZero = true
        }
    }
    
    func displayLinkUpdated() {
        
        if let displayLink = displayLink {
            var currentTime = displayLink.timestamp
            var deltaTime: CFTimeInterval
            
            if nextDeltaTimeZero {
                nextDeltaTimeZero = false
                deltaTime = 0.0
            } else {
                deltaTime = currentTime - previousTimestamp
            }
            
            previousTimestamp = currentTime
            
            delegate.updateDisplay(deltaTime)
        }
    }
}
