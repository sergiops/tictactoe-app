//
//  GameBoardView.swift
//  tictactoe
//
//  Created by Sergio P. on 7/21/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    let lineWidth: CGFloat = 10.0
    
    let boardLayer: GameBoardLayer = GameBoardLayer()
    let gameOverLayer: MessageLayer = MessageLayer()
    
    // Setup and draw the tictactoe board for the first time.
    override func draw(_ rect: CGRect) {
        self.layer.addSublayer(boardLayer)
        self.layer.addSublayer(gameOverLayer)
        
        let frameSize = self.frame.size
        boardLayer.cellWidth = (frameSize.width/3.0)
        boardLayer.cellHeight = (frameSize.height/3.0)
        boardLayer.cellOffset = CGFloat(lineWidth/6.0)
        boardLayer.initCellCenters()
        boardLayer.initLinePositions(with: frameSize)
        boardLayer.drawCellLines()
    }
    
    // Given a tap location, draw the marking for the specified player.
    public func drawPlayerMark(at cell: Int, for player: Player) {
        boardLayer.drawPlayerMark(at: cell, for: player)
    }
    
    // Determine which cell was tapped based on the location given.
    public func getCellNumber(tap location: CGPoint) -> Int {
        return boardLayer.getCellNumber(tap: location)
    }
    
    public func clear() {
        boardLayer.clearWithFadeOut(willRedraw: true)
        gameOverLayer.clearWithFadeOut()
    }
    
    // Wait for drawing animation to complete, then transition
    // to the game over message.
    public func showGameOverMessage(winner: Player, cell: Int) {
        let message = getMessageForGameResult(winner)
        let messageRect = createMessageRect()
        let icon = boardLayer.getPlayerMark(for: winner, at: cell)
        let iconOffset = boardLayer.getDifferenceFromCenter(for: cell)
        let delay = boardLayer.markAnimDuration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay,
                                      execute: {
            self.transitionToMessage(winner, message, messageRect, icon, iconOffset)
        })
    }
    
    // Callback function to display the message layer, and hide the
    // game layer.
    private func transitionToMessage(_ winner: Player,
                                     _ msg: String,
                                     _ rect: CGRect,
                                     _ shapelayer: CAShapeLayer,
                                     _ layerOffset: CGPoint) {
        boardLayer.clearWithFadeOut(willRedraw: false)
        if winner == .NONE {
            gameOverLayer.moveInBottom(message: msg,
                                       messageRect: rect,
                                       icon: shapelayer)
        } else {
            gameOverLayer.showGameOverMessage(message: msg,
                                              messageRect: rect,
                                              icon: shapelayer,
                                              iconOffset: layerOffset)
        }
    }
    
    private func getMessageForGameResult(_ player: Player) -> String {
        if player == .NONE {
            return "DRAW"
        } else {
            return "WINNER"
        }
    }
    
    // Return a CGRect positioned in the lower third of the view.
    private func createMessageRect() -> CGRect {
        let height = self.frame.height
        let width = self.frame.width
        let rect = CGRect(x: 0.0,
                          y: height - (height/3.0),
                          width: width,
                          height: height/3.0)
        return rect
    }
    
}
