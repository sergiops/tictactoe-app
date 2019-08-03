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
    let lineWidth: CGFloat = 10.0
    let lineAnimDuration: Double = 0.75
    let markAnimDuration: Double = 0.25
    
    var lineV0: Line!
    var lineV1: Line!
    var lineH0: Line!
    var lineH1: Line!
    var cellCenters: [CGPoint] = Array(repeating: CGPoint(), count: 9)
    
    var cellWidth:CGFloat!
    var cellHeight:CGFloat!
    var cellOffset:CGFloat!
    
    // Setup and draw the tictactoe board for the first time.
    override func draw(_ rect: CGRect) {
        let frameSize = self.frame.size
        self.cellWidth = (frameSize.width/3.0)
        self.cellHeight = (frameSize.height/3.0)
        self.cellOffset = CGFloat(lineWidth/6.0)
        initCellCenters()
        initLinePositions(with: frameSize)
        drawCellLines()
    }
    
    // Given a tap location, draw the marking for the specified player.
    public func drawPlayerMark(at cell: Int, for player: Player) {
        let point = cellCenters[cell]
        switch player {
        case .EX:
            drawAnimatedCross(at: point,
                              size: ((cellWidth/2)-(lineWidth*2))/sqrt(2),
                              color: blueColor.cgColor)
        case .OH:
            drawAnimatedCircle(at: point,
                               radius: (cellWidth/2)-(lineWidth*2),
                               color: redColor.cgColor)
        default:
            return
        }
    }
    
    // Draw the tictacte board, with animation, using the calculated lines.
    public func drawCellLines() {
        let linePath1 = UIBezierPath()
        let linePath2 = UIBezierPath()
        
        linePath1.move(to: lineV0.start)
        linePath1.addLine(to: lineV0.end)
        linePath2.move(to: lineV1.start)
        linePath2.addLine(to: lineV1.end)
        linePath1.move(to: lineH0.start)
        linePath1.addLine(to: lineH0.end)
        linePath2.move(to: lineH1.start)
        linePath2.addLine(to: lineH1.end)
        
        let pairLayer1 = newShapeLayer(for: linePath1.cgPath,
                                            with: lineColor.cgColor,
                                            lineWidth: self.lineWidth)
        let pairLayer2 = newShapeLayer(for: linePath2.cgPath,
                                          with: lineColor.cgColor,
                                          lineWidth: self.lineWidth)
        
        let animation = getStrokeAnimation(lineAnimDuration)
        pairLayer1.add(animation, forKey: "horizontalLineAnim")
        pairLayer2.add(animation, forKey: "verticalLineAnim")
        
        self.layer.addSublayer(pairLayer1)
        self.layer.addSublayer(pairLayer2)
    }
    
    // Determine which cell was tapped based on the location given.
    public func getCellNumber(tap location: CGPoint) -> Int {
        if location.x < cellWidth && location.y < cellHeight {
            return 0
        } else if location.x < cellWidth*2 && location.y < cellHeight {
            return 1
        } else if location.x < cellWidth*3 && location.y < cellHeight {
            return 2
        } else if location.x < cellWidth && location.y < cellHeight*2 {
            return 3
        } else if location.x < cellWidth*2 && location.y < cellHeight*2 {
            return 4
        } else if location.x < cellWidth*3 && location.y < cellHeight*2 {
            return 5
        } else if location.x < cellWidth && location.y < cellHeight*3 {
            return 6
        } else if location.x < cellWidth*2 && location.y < cellHeight*3 {
            return 7
        } else {
            return 8
        }
    }
    
    public func clear() {
        self.layer.sublayers?.removeAll()
    }
    
    //////////////////////////////////////////////
    // Private members
    //////////////////////////////////////////////
    private func initCellCenters() {
        let col1: CGFloat = (cellWidth-cellOffset)/CGFloat(2.0)
        let col2: CGFloat = (cellWidth*CGFloat(3.0))/CGFloat(2.0)
        let col3: CGFloat = cellWidth*CGFloat(3.0) - (cellWidth-cellOffset)/CGFloat(2.0)
        let row1: CGFloat = (cellHeight-cellOffset)/CGFloat(2.0)
        let row2: CGFloat = (cellHeight*CGFloat(3.0))/CGFloat(2.0)
        let row3: CGFloat = cellHeight*CGFloat(3.0) - (cellHeight-cellOffset)/CGFloat(2.0)
        
        cellCenters[0] = CGPoint(x: col1, y: row1)
        cellCenters[1] = CGPoint(x: col2, y: row1)
        cellCenters[2] = CGPoint(x: col3, y: row1)
    
        cellCenters[3] = CGPoint(x: col1, y: row2)
        cellCenters[4] = CGPoint(x: col2, y: row2)
        cellCenters[5] = CGPoint(x: col3, y: row2)
        
        cellCenters[6] = CGPoint(x: col1, y: row3)
        cellCenters[7] = CGPoint(x: col2, y: row3)
        cellCenters[8] = CGPoint(x: col3, y: row3)
    }
    
    // Callculate the position of the tictactoe lines.
    private func initLinePositions(with frameSize: CGSize) {
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
    
    // Draw a cross at the specified point.
    private func drawAnimatedCross(at point: CGPoint, size: CGFloat, color: CGColor) {
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: point.x-size, y: point.y-size))
        crossPath.addLine(to: CGPoint(x: point.x+size, y: point.y+size))
        crossPath.move(to: CGPoint(x: point.x+size, y: point.y-size))
        crossPath.addLine(to: CGPoint(x: point.x-size, y: point.y+size))
        
        let shapeLayer = newShapeLayer(for: crossPath.cgPath,
                                       with: color,
                                       lineWidth: CGFloat(15.0))
        shapeLayer.add(getStrokeAnimation(markAnimDuration), forKey: "crossMarking")
        self.layer.addSublayer(shapeLayer)
    }
    
    // Draw a circle at the specified point.
    private func drawAnimatedCircle(at point: CGPoint, radius: CGFloat, color: CGColor) {
        let circlePath = UIBezierPath(arcCenter: point,
                                      radius: radius,
                                      startAngle: -(CGFloat.pi/2),
                                      endAngle: (3 * CGFloat.pi)/2,
                                      clockwise: true)
        
        let shapeLayer = newShapeLayer(for: circlePath.cgPath,
                                       with: color,
                                       lineWidth: CGFloat(15.0))
        shapeLayer.add(getStrokeAnimation(markAnimDuration), forKey: "cirlceMarking")
        self.layer.addSublayer(shapeLayer)
    }
    
    // Return a shape layer with the shape path and styling.
    private func newShapeLayer(for shapePath: CGPath,
                                 with color: CGColor,
                                 lineWidth: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        return shapeLayer
    }
    
    // Create the stroke animation for the shape and return it.
    private func getStrokeAnimation(_ dur: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = dur
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
