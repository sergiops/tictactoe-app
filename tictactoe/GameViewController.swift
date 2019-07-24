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
    @IBOutlet weak var gameBoardCanvas: GameBoardView!
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
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
        
        // Determine the selected mode from the main menu
        switch mode {
        case .PVP:
            modeLabel.text = "PVP Selected"
        case .CPU:
            modeLabel.text = "CPU Selected"
        }
        
        // Initialize tictactoe model
        newGame()
        
        // Calculate canvas values
        setupGameCanvas()
        
    }
    
    func newGame() {
        currentPlayer = Player.EX
        board = []
        for _ in 0...8 {
            board.append(.NONE)
        }
    }
    
    func restartGame() {
        newGame()
        image0.image = nil
        image1.image = nil
        image2.image = nil
        image3.image = nil
        image4.image = nil
        image5.image = nil
        image6.image = nil
        image7.image = nil
        image8.image = nil
    }
    
    func setupGameCanvas() {
        let frameSize = gameBoardCanvas.frame.size
        let tileWidth = frameSize.width/3
        let titleHeight = frameSize.width/3
        gameBoardCanvas.lineV0 = Line(p0: CGPoint(x: tileWidth, y: 0),
                                      p1: CGPoint(x: tileWidth, y: frameSize.height)
        )
        gameBoardCanvas.lineV1 = Line(p0: CGPoint(x: frameSize.width - tileWidth, y: 0),
                                      p1: CGPoint(x: frameSize.width - tileWidth, y: frameSize.height)
        )
        gameBoardCanvas.lineH0 = Line(p0: CGPoint(x: 0, y: titleHeight),
                                      p1: CGPoint(x: frameSize.width, y: titleHeight)
        )
        gameBoardCanvas.lineH1 = Line(p0: CGPoint(x: 0, y: frameSize.height - titleHeight),
                                      p1: CGPoint(x: frameSize.width, y: frameSize.height - titleHeight)
        )
    }
    
    @IBAction func handleImage0Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image0, index: 0)
    }
    @IBAction func handleImage1Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image1, index: 1)
    }
    @IBAction func handleImage2Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image2, index: 2)
    }
    @IBAction func handleImage3Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image3, index: 3)
    }
    @IBAction func handleImage4Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image4, index: 4)
    }
    @IBAction func handleImage5Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image5, index: 5)
    }
    @IBAction func handleImage6Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image6, index: 6)
    }
    @IBAction func handleImage7Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image7, index: 7)
    }
    @IBAction func handleImage8Tap(_ sender: UITapGestureRecognizer) {
        updateGameState(for: image8, index: 8)
    }
    
    func updateGameState(for img: UIImageView, index: Int) {
        if board[index] == Player.NONE {
            board[index] = currentPlayer
            img.image = UIImage(named: currentPlayer.rawValue)
            handleGameOver()
        }
    }
        
    func handleGameOver() {
        if playerWon(currentPlayer, with: board) {
            updateScores()
            // Show victory message
            // Show restart button
            restartGame()
        } else if boardFull(board) {
            // Show tied message
            // Show restart button
            restartGame()
        } else { // Game is not over
            currentPlayer = currentPlayer.opposite()
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
