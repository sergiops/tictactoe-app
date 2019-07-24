//
//  GameBoardView.swift
//  tictactoe
//
//  Created by Sergio P. on 7/21/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

struct Line {
    var p0,p1: CGPoint!
}

class GameBoardView: UIView {
    
    var lineV0: Line!
    var lineV1: Line!
    var lineH0: Line!
    var lineH1: Line!
    
    // Draw the tic-tac-toe lines onto the canvas
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(10.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.move(to: lineV0.p0)
        context?.addLine(to: lineV0.p1)
        context?.move(to: lineV1.p0)
        context?.addLine(to: lineV1.p1)
        context?.move(to: lineH0.p0)
        context?.addLine(to: lineH0.p1)
        context?.move(to: lineH1.p0)
        context?.addLine(to: lineH1.p1)
        
        context?.strokePath()
    }
    
}
