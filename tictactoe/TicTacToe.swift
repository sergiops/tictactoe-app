//
//  TicTacToe.swift
//  tictactoe
//

import Foundation

enum GameMode {
    case PVP
    case CPU
}

enum Player: String {
    case CROSS = "cross"
    case CIRCLE = "circle"
    case NONE = "none"
    
    func next() -> Player {
        switch self {
        case .CROSS:
            return .CIRCLE
        case .CIRCLE:
            return .CROSS
        default:
            return .NONE
        }
    }
}

class TicTacToe {
    var mode: GameMode!
    var currentPlayer: Player!
    var isGameover: Bool = false
    var crossScore:Int = 0
    var cricleScore:Int = 0
    private var board: [Player] = Array(repeating: Player.NONE, count: 9)
    
    init(mode: GameMode, firstPlayer: Player) {
        self.mode = mode
        self.currentPlayer = firstPlayer
    }
    
    public func isMoveValid(_ cell: Int) -> Bool {
        return board[cell] == Player.NONE && isGameover == false
    }
    
    public func commitMove(_ cell: Int) {
        board[cell] = currentPlayer
        determineGameOutcome()
    }
    
    public func restartGame() {
        isGameover = false
        currentPlayer = Player.CROSS
        board = Array(repeating: Player.NONE, count: 9)
    }
    
    //////////////////////////////////////////////
    // Private members for game logic
    //////////////////////////////////////////////
    private func determineGameOutcome() {
        if didPlayerWin(currentPlayer, board) {
            isGameover = true
            updateScores()
        } else if isBoardFull(board) {
            isGameover = true
            currentPlayer = Player.NONE
        } else {
            currentPlayer = currentPlayer.next()
        }
    }
    
    private func updateScores() {
        if currentPlayer == Player.CROSS {
            crossScore += 1
        } else if currentPlayer == Player.CIRCLE {
            cricleScore += 1
        }
    }
    
    private func didPlayerWin(_ player: Player, _ board: [Player]) -> Bool {
        if board[0] == player && board[1] == player && board[2] == player {
            return true
        }
        if board[3] == player && board[4] == player && board[5] == player {
            return true
        }
        if board[6] == player && board[7] == player && board[8] == player {
            return true
        }
        if board[0] == player && board[3] == player && board[6] == player {
            return true
        }
        if board[1] == player && board[4] == player && board[7] == player {
            return true
        }
        if board[2] == player && board[5] == player && board[8] == player {
            return true
        }
        if board[0] == player && board[4] == player && board[8] == player {
            return true
        }
        if board[2] == player && board[4] == player && board[6] == player {
            return true
        }
        return false
    }
    
    private func isBoardFull(_ board: [Player]) -> Bool {
        for p in board {
            if p == .NONE {
                return false
            }
        }
        return true
    }
    
}
