//
//  GameBoardView.swift
//  tictactoe
//
//  Created by Sergio P. on 7/21/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

struct Line {
    var start,end: CGPoint!
}

class CanvasView: UIView {
    let redColor: UIColor = #colorLiteral(red: 0.7843137255, green: 0.2078431373, blue: 0.137254902, alpha: 1)
    let blueColor: UIColor = #colorLiteral(red: 0.137254902, green: 0.7137254902, blue: 0.7843137255, alpha: 1)
    let lineColor: UIColor = #colorLiteral(red: 0.3843137255, green: 0.3843137255, blue: 0.3843137255, alpha: 1)
    let lineWidth: CGFloat = 10.0
    
    var lineV0: Line!
    var lineV1: Line!
    var lineH0: Line!
    var lineH1: Line!
    
    var cellWidth:CGFloat!
    var cellHeight:CGFloat!
    var cellOffset:CGFloat!
    
    // Draw the tic-tac-toe lines onto the canvas
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(lineColor.cgColor)
        context?.move(to: lineV0.start)
        context?.addLine(to: lineV0.end)
        context?.move(to: lineV1.start)
        context?.addLine(to: lineV1.end)
        context?.move(to: lineH0.start)
        context?.addLine(to: lineH0.end)
        context?.move(to: lineH1.start)
        context?.addLine(to: lineH1.end)
        context?.strokePath()
    }
    
    // Determine positions of tictactoe lines
    public func setup() {
        let frameSize = self.frame.size
        self.cellWidth = (frameSize.width/3.0)
        self.cellWidth = (frameSize.height/3.0)
        self.cellOffset = CGFloat(lineWidth/6.0)
        
        
        self.lineV0 = Line(start: CGPoint(x: cellWidth - cellOffset, y: 0),
                             end: CGPoint(x: cellWidth - cellOffset, y: frameSize.height)
        )
        self.lineV1 = Line(start: CGPoint(x: (2.0 * cellWidth) + cellOffset, y: 0),
                             end: CGPoint(x: (2.0 * cellWidth) + cellOffset, y: frameSize.height)
        )
        self.lineH0 = Line(start: CGPoint(x: 0, y: cellWidth - cellOffset),
                             end: CGPoint(x: frameSize.width, y: cellWidth - cellOffset)
        )
        self.lineH1 = Line(start: CGPoint(x: 0, y: (2.0 * cellWidth) + cellOffset),
                             end: CGPoint(x: frameSize.width, y: (2.0 * cellWidth) + cellOffset)
        )
    }
    
    public func drawPlayerMark(with tapLocation: CGPoint, for player: Player) {
        switch player {
        case .EX:
            drawAnimatedCircle(point: tapLocation,
                               radius: (cellWidth/2)-(lineWidth*2),
                               color: blueColor.cgColor)
        case .OH:
            drawAnimatedCircle(point: tapLocation,
                               radius: (cellWidth/2)-(lineWidth*2),
                               color: redColor.cgColor)
        default:
            print("no player specified")
        }
    }
    
    // Draw a circle at the specified point
    private func drawAnimatedCircle(point: CGPoint, radius: CGFloat, color: CGColor) {
        let shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: -(CGFloat.pi/2), endAngle: (3 * CGFloat.pi)/2, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 15
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.25
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "circleAnimation")
        self.layer.addSublayer(shapeLayer)
    }
    
}
