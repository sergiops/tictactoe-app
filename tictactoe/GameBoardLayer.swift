//
//  GameBoardLayer.swift
//  tictactoe
//
//  Created by Sergio P. on 8/11/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

struct Line {
    var start,end: CGPoint!
}

class GameBoardLayer: CALayer {
    let lineWidth: CGFloat = 10.0
    let lineAnimDuration: Double = 0.5
    let markAnimDuration: Double = 0.3
    let fadeDuration: Double = 0.2
    
    var lineV0: Line!
    var lineV1: Line!
    var lineH0: Line!
    var lineH1: Line!
    
    var cellCenters: [CGPoint] = Array(repeating: CGPoint(), count: 9)
    var cellWidth:CGFloat!
    var cellHeight:CGFloat!
    var cellOffset:CGFloat!
    
    // Setup and draw the tictactoe board for the first time.
    public func draw() {
        let frameSize = self.frame.size
        print("from GameBoardLayer")
        print(self.frame.origin)
        print(self.frame.size)
        self.cellWidth = (frameSize.width/3.0)
        self.cellHeight = (frameSize.height/3.0)
        self.cellOffset = CGFloat(lineWidth/6.0)
        initCellCenters()
        initLinePositions(with: frameSize)
        drawCellLines()
    }
    
    public func getDifferenceFromCenter(for cell: Int) -> CGPoint {
        let center = cellCenters[4]
        let end = cellCenters[cell]
        return CGPoint(x: center.x-end.x, y: center.y-end.y)
    }
        
    // Return a shape layer with player marking drawn at the given cell.
    public func getPlayerMark(for player: Player, at cell: Int) -> CAShapeLayer {
        let point = cellCenters[cell]
        switch player {
        case .CROSS:
            let crossPath = createCrossPath(center: point,
                                            size: ((cellWidth/2)-(lineWidth*2))/sqrt(2))
            return addPathToLayer(for: crossPath,
                                  with: blueColor.cgColor,
                                  lineWidth: CGFloat(15.0))
        case .CIRCLE:
            let circlePath = createCirclePath(center: point,
                                              radius: (cellWidth/2)-(lineWidth*2))
            return addPathToLayer(for: circlePath,
                                  with: redColor.cgColor,
                                  lineWidth: CGFloat(15.0))
        default:
            return createPlayerMarks()
        }
    }
    
    
    // Given a tap location, draw the marking for the specified player.
    public func drawPlayerMark(at cell: Int, for player: Player) {
        let point = cellCenters[cell]
        switch player {
        case .CROSS:
            drawAnimatedCross(at: point,
                              size: ((cellWidth/2)-(lineWidth*2))/sqrt(2),
                              color: blueColor.cgColor)
        case .CIRCLE:
            drawAnimatedCircle(at: point,
                               radius: (cellWidth/2)-(lineWidth*2),
                               color: redColor.cgColor)
        default:
            return
        }
    }
    
    // Draw the tictacte board, with animation, using the calculated lines.
    public func drawCellLines() {
        self.removeAllAnimations()
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
        
        var pairLayer1 = addPathToLayer(for: linePath1.cgPath,
                                        with: lineColor.cgColor,
                                        lineWidth: self.lineWidth)
        var pairLayer2 = addPathToLayer(for: linePath2.cgPath,
                                        with: lineColor.cgColor,
                                        lineWidth: self.lineWidth)
        
        pairLayer1 = animateLayerWithStroke(layer: pairLayer1,
                                            duration: lineAnimDuration)
        pairLayer2 = animateLayerWithStroke(layer: pairLayer2,
                                            duration: lineAnimDuration)
        
        self.addSublayer(pairLayer1)
        self.addSublayer(pairLayer2)
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
    
    // Remove all sublayers and add fade out animation.
    public func clearWithFadeOut(willRedraw: Bool) {
        CATransaction.begin()
        let animation = getfadeOutAnimation(fadeDuration, willRedraw)
        CATransaction.setCompletionBlock(
            {
                self.sublayers?.removeAll()
                if willRedraw {
                    self.drawCellLines()
                }
            }
        )
        self.add(animation, forKey: "gameBoardLayerFadeOut")
        CATransaction.commit()
    }

    //////////////////////////////////////////////
    // Private members
    //////////////////////////////////////////////
    
    // Calculate the center point of each cell.
    public func initCellCenters() {
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
    public func initLinePositions(with frameSize: CGSize) {
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

    private func drawAnimatedCross(at point: CGPoint, size: CGFloat, color: CGColor) {
        let crossPath = createCrossPath(center: point, size: size)
        var crossLayer = addPathToLayer(for: crossPath,
                                        with: color,
                                        lineWidth: CGFloat(15.0))
        crossLayer = animateLayerWithStroke(layer: crossLayer, duration: markAnimDuration)
        self.addSublayer(crossLayer)
    }

    private func drawAnimatedCircle(at point: CGPoint, radius: CGFloat, color: CGColor) {
        let circlePath = createCirclePath(center: point, radius: radius)
        var circleLayer = addPathToLayer(for: circlePath,
                                         with: color,
                                         lineWidth: CGFloat(15.0))
        circleLayer = animateLayerWithStroke(layer: circleLayer,
                                             duration: markAnimDuration)
        self.addSublayer(circleLayer)
    }

    private func createCirclePath(center: CGPoint, radius: CGFloat) -> CGPath {
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: -(CGFloat.pi/2),
                                      endAngle: (3 * CGFloat.pi)/2,
                                      clockwise: true)
        return circlePath.cgPath
    }

    private func createCrossPath(center: CGPoint, size: CGFloat) -> CGPath {
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: center.x-size, y: center.y-size))
        crossPath.addLine(to: CGPoint(x: center.x+size, y: center.y+size))
        crossPath.move(to: CGPoint(x: center.x+size, y: center.y-size))
        crossPath.addLine(to: CGPoint(x: center.x-size, y: center.y+size))
        return crossPath.cgPath
    }

    // Add path to shape layer and style it.
    private func addPathToLayer(for path: CGPath,
                                with color: CGColor,
                                lineWidth: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        return shapeLayer
    }

    private func animateLayerWithStroke(layer: CAShapeLayer,
                                        duration: Double) -> CAShapeLayer {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut)

        layer.strokeEnd = 0
        layer.add(animation, forKey: "strokeAnimation")
        return layer
    }
    
    private func getfadeOutAnimation(_ duration: Double,
                                     _ willRedraw: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 0
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
                
        return animation
    }
    
    private func createPlayerMarks() -> CAShapeLayer {
        let anchor = cellCenters[4]
        let spacing = cellWidth * (0.1)
        let crossCenter = CGPoint(x: anchor.x - cellWidth/3 - spacing, y: anchor.y)
        let circleCenter = CGPoint(x: anchor.x + cellWidth/3 + spacing, y: anchor.y)
        
        let crossPath = createCrossPath(center: crossCenter,
                                        size: ((cellWidth/2)-(lineWidth*2))/sqrt(2))
        let crossLayer = addPathToLayer(for: crossPath,
                              with: blueColor.cgColor,
                              lineWidth: CGFloat(15.0))
        
        let circlePath = createCirclePath(center: circleCenter,
                                          radius: (cellWidth/2)-(lineWidth*2))
        let circleLayer = addPathToLayer(for: circlePath,
                              with: redColor.cgColor,
                              lineWidth: CGFloat(15.0))
        
        let layerGroup = CAShapeLayer()
        layerGroup.addSublayer(crossLayer)
        layerGroup.addSublayer(circleLayer)
        return layerGroup
    }
}
