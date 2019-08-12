//
//  ActiveIndicator.swift
//  tictactoe
//
//  Created by Sergio P. on 8/3/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class ActiveIndicator: UIView {

    var height: CGFloat!
    var width: CGFloat!
    var indicatorWidth: CGFloat = 32.0
    var startingPlayer: Player!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let frameSize = self.frame.size
        height = frameSize.height
        width = frameSize.width
        self.showIndicator(player: startingPlayer)
    }
    
    public func showIndicator(player: Player) {
        self.layer.sublayers?.removeAll()
        var p0, p1: CGPoint!
        if player == Player.CROSS {
            p0 = CGPoint(x: 0, y: 0)
            p1 = CGPoint(x: indicatorWidth, y: 0)
            addIndicatorLayer(start: p0, end: p1, color: blueColor.cgColor)
        } else {
            p0 = CGPoint(x: width, y: 0)
            p1 = CGPoint(x: width - indicatorWidth, y: 0)
            addIndicatorLayer(start: p0, end: p1, color: redColor.cgColor)
        }
    }
    
    private func addIndicatorLayer(start: CGPoint, end: CGPoint, color: CGColor) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color
        layer.lineWidth = 5.0
        layer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.lineCap = CAShapeLayerLineCap.round
        layer.strokeEnd = 0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.25
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        layer.add(animation, forKey: "indicatorStroke")
        self.layer.addSublayer(layer)
    }

}
