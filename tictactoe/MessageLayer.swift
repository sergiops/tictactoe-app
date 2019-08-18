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
    
    public func moveInBottom(message: String,
                             messageRect: CGRect,
                             icon: CAShapeLayer) {

        let text = createTextLayer(string: message, rect: messageRect)
        let animatedText = addMoveInBottomAnimation(layer: text) as! CATextLayer
        let animatedIcon = addMoveInBottomAnimation(layer: icon) as! CAShapeLayer
        
        self.addSublayer(animatedIcon)
        self.addSublayer(animatedText)
    }
    
    public func showGameOverMessage(message: String,
                                    messageRect: CGRect,
                                    icon: CAShapeLayer,
                                    iconOffset: CGPoint) {
        let iconAnimation = getTranslationAnimation(translateDuration, iconOffset)
        icon.add(iconAnimation, forKey: "translateCenter")
        var text = createTextLayer(string: message, rect: messageRect)
        text = addMoveInBottomAnimation(layer: text) as! CATextLayer
        
        self.addSublayer(icon)
        self.addSublayer(text)
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
    
    // Return a text layer with the specified string.
    private func createTextLayer(string: String, rect: CGRect) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.frame = rect
        textLayer.string = string
        textLayer.font = UIFont.systemFont(ofSize: CGFloat(20.0),
                                           weight: UIFont.Weight.heavy)
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
    
    private func addMoveInBottomAnimation(layer: CALayer) -> CALayer {
        let moveIn = getSlideInFadeInAnimation(offsetY: 75)
        layer.add(moveIn, forKey: "moveInBottom")
        return layer
    }
    
    private func getSlideInFadeInAnimation(offsetY: Int) -> CAAnimationGroup {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0
        fadeIn.toValue = 1
        
        let translation = CABasicAnimation(keyPath: "transform.translation.y")
        translation.fromValue = offsetY
        
        let group = CAAnimationGroup()
        group.animations = [fadeIn, translation]
        group.duration = 0.75
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        return group
    }
    
}
