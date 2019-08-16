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
        let winnerMark = boardLayer.getPlayerMark(for: winner, at: cell)
        let newPosition = boardLayer.getDifferenceFromCenter(for: cell)
        let delay = boardLayer.markAnimDuration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay,
                                      execute: {
            self.transitionToMessage(winner, winnerMark, newPosition)
        })
    }
    
    private func transitionToMessage(_ winner: Player,
                                     _ shapelayer: CAShapeLayer,
                                     _ newPosition: CGPoint) {
        boardLayer.clearWithFadeOut(willRedraw: false)
        gameOverLayer.showGameOverMessage(winner: winner,
                                          playerMark: shapelayer,
                                          moveTo: newPosition)
    }
    
}
