//
//  GameViewController.swift
//  tictactoe
//
//  Created by Sergio P. on 7/18/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

enum GameMode {
    case PVP
    case CPU
}

enum Player: String {
    case EX = "ex"
    case OH = "oh"
    case NONE = "none"
    
    func opposite() -> Player {
        switch self {
        case .EX:
            return .OH
        case .OH:
            return .EX
        default:
            return .EX
        }
    }
}

class GameViewController: UIViewController {
    @IBOutlet weak var canvas: CanvasView!
    @IBOutlet weak var activeIndicator: ActiveIndicator!
    
    @IBOutlet weak var exScoreLabel: UILabel!
    @IBOutlet weak var ohScoreLabel: UILabel!
    
    var mode:GameMode = GameMode.PVP
    var currentPlayer:Player = Player.EX
    var board: [Player]!
    var exScore:Int = 0
    var ohScore:Int = 0
    
    @IBOutlet weak var modeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        canvas.backgroundColor = backgroundColor
        activeIndicator.backgroundColor = appBarColor
        
        // Determine the selected mode from the main menu
        switch mode {
        case .PVP:
            modeLabel.text = "PVP Selected"
        case .CPU:
            modeLabel.text = "CPU Selected"
        }
        
        // Initialize tictactoe model
        currentPlayer = Player.EX
        board = Array(repeating: Player.NONE, count: 9)
        activeIndicator.startingPlayer = currentPlayer
    }
    
    @IBAction func onCanvasTap(_ sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: canvas)
        let cell: Int = canvas.getCellNumber(tap: location)
        handlePlayerMove(for: cell)
    }
    
    func newGame() {
        currentPlayer = Player.EX
        board = Array(repeating: Player.NONE, count: 9)
        canvas.clear()
        canvas.drawCellLines()
        activeIndicator.showIndicator(player: currentPlayer)
    }
        
    @IBAction func onPlayAgain(_ sender: UIButton) {
        newGame()
    }
    
    func handlePlayerMove(for cell: Int) {
        if board[cell] == Player.NONE {
            board[cell] = currentPlayer
            canvas.drawPlayerMark(at: cell, for: currentPlayer)
            handleMoveOutcome()
        }
    }
        
    func handleMoveOutcome() {
        if playerWon(currentPlayer, with: board) {
            updateScores()
            newGame()
        } else if boardFull(board) {
            newGame()
        } else { // Game is not over
            currentPlayer = currentPlayer.opposite()
            activeIndicator.showIndicator(player: currentPlayer)
        }
    }
    
    func updateScores() {
        switch currentPlayer {
        case .EX:
            exScore += 1
            exScoreLabel.text = String(exScore)
        case .OH:
            ohScore += 1
            ohScoreLabel.text = String(ohScore)
        default:
            return
        }
    }
    
}
