//
//  MessageLayer.swift
//  tictactoe
//
//  Created by Sergio P. on 8/11/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class MessageLayer: CALayer {
    let fadeDuration: Double = 0.2

    public func showGameOverMessage(winner: Player, playerMark: CAShapeLayer) {
        self.addSublayer(playerMark)
    }
    
    public func clearWithFadeOut() {
        self.removeAllAnimations()
        
        CATransaction.begin()
        let animation = getfadeOutAnimation(fadeDuration)
        CATransaction.setCompletionBlock(
            {
                self.sublayers?.removeAll()
            }
        )
        self.add(animation, forKey: "messageLayerFadeOut")
        CATransaction.commit()
    }
    
    // Create a fade out animation with some duration and return it.
    private func getfadeOutAnimation(_ duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 0
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        return animation
    }
}
