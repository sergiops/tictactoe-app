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
    let translateDuration: Double = 0.5

    public func showGameOverMessage(message: String,
                                    messageRect: CGRect,
                                    icon: CAShapeLayer,
                                    iconOffset: CGPoint) {
        
        let animation = getTranslationAnimation(translateDuration, iconOffset)
        icon.add(animation, forKey: "translateCenter")
        
        let message = createTextLayer(string: message, rect: messageRect)
        self.addSublayer(icon)
        self.addSublayer(message)
    }
    
    // Hide the message from the user's view.
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
    
    private func createTextLayer(string: String, rect: CGRect) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.frame = rect
        textLayer.string = string
        textLayer.font = UIFont.boldSystemFont(ofSize: CGFloat(20.0))
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        return textLayer
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
    
    private func getTranslationAnimation(_ duration: Double,
                                         _ moveTo: CGPoint) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.toValue = moveTo
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.beginTime = CACurrentMediaTime() + self.fadeDuration
        return animation
    }
    
}
