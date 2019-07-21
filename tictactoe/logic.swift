//
//  logic.swift
//  tictactoe
//
//  Created by Sergio P. on 7/20/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import Foundation

func playerWon(_ player: Player, with board: [Player]) -> Bool {
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

func boardFull(_ board: [Player]) -> Bool {
    for p in board {
        if p == .NONE {
            return false
        }
    }
    return true
}
