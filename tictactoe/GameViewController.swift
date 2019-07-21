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
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    var mode:GameMode = GameMode.PVP
    var currentPlayer:Player = Player.EX
    
    var board: [Player] = []
    
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
        
        // Initialize tictactoe board
        for _ in 0...8 {
            board.append(.NONE)
        }
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
            img.image = UIImage(named: currentPlayer.rawValue)
            board[index] = currentPlayer
            currentPlayer = currentPlayer.opposite()
        }
    }
    
}
