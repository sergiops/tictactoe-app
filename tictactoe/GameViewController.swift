//
//  GameViewController.swift
//  tictactoe
//
//  Created by Sergio P. on 7/18/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var canvas: CanvasView!
    @IBOutlet weak var activeIndicator: ActiveIndicator!
    
    @IBOutlet weak var crossScoreLabel: UILabel!
    @IBOutlet weak var circleScoreLabel: UILabel!
    
    var selectedMode:GameMode = GameMode.PVP
    var selectedPlayer:Player = Player.CROSS
    var game: TicTacToe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        canvas.backgroundColor = backgroundColor
        activeIndicator.backgroundColor = appBarColor
        
        activeIndicator.startingPlayer = selectedPlayer
        game = TicTacToe(mode: selectedMode, firstPlayer: selectedPlayer)
    }
    
    @IBAction func onCanvasTap(_ sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: canvas)
        let cell: Int = canvas.getCellNumber(tap: location)
        handleCellTap(for: cell)
    }
    
    func newGame() {
        canvas.clear()
        game.restartGame()
        activeIndicator.showIndicator(player: game.currentPlayer)
    }
        
    @IBAction func onPlayAgain(_ sender: UIButton) {
        newGame()
    }
    
    func handleCellTap(for cell: Int) {
        if game.isMoveValid(cell) {
            canvas.drawPlayerMark(at: cell, for: game.currentPlayer)
            game.commitMove(cell)
            handleMoveOutcome(lastMove: cell)
        }
    }
        
    func handleMoveOutcome(lastMove: Int) {
        if game.isGameover {
            updateScoreLabels()
            canvas.showGameOverMessage(winner: game.currentPlayer,
                                       cell: lastMove)
        } else {
            activeIndicator.showIndicator(player: game.currentPlayer)
        }
    }
    
    func updateScoreLabels() {
        crossScoreLabel.text = String(game.crossScore)
        circleScoreLabel.text = String(game.cricleScore)
    }
    
}
