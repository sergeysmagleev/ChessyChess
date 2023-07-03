//
//  MovePossibilityChecker.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 20.05.23.
//

import Foundation

class MovePossibilityChecker {
    
    func checkMovePossible(_ move: Move, on board: GameBoard) -> Bool {
        guard let currentPlayer = board[move.source].chessPiece?.player else {
            return false
        }
        var boardAfterMove = board
        boardAfterMove.makeMove(move)
        guard let kingLocation = boardAfterMove.locateKing(player: currentPlayer) else {
            return false
        }
        return KingThreatStatusCheck().isKingSafe(boardAfterMove, origin: kingLocation, player: currentPlayer)
    }
    
}
