//
//  GameStateChecker.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation

class GameStateChecker {
    
    private let kingChecker = KingThreatStatusCheck()
    private let moveGenerator = MoveGenerator()
    
    func checkState(board: GameBoard, player: Player) -> GameState {
        guard let kingLocation = board.locateKing(player: player) else {
            return .undefined
        }
        let isKingUnderAttack = kingChecker.isKingUnderAttack(board, origin: kingLocation, player: player)
        let possibleMoves = moveGenerator.listOfPossibleMoves(board: board, player: player)
        switch (isKingUnderAttack, possibleMoves.isNotEmpty) {
        case (false, true):
            return .normal
        case (false, false):
            return .stalemate
        case (true, true):
            return .check
        case (true, false):
            return .checkmate
        }
    }
    
}
