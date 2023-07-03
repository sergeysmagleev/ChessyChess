//
//  EnPassantCheck.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 09.05.23.
//

import Foundation

class EnPassantCheck: MoveStrategy {
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        var moves: [Coordinate] = []
        let topLeftStep = origin + (player.forward, -1)
        let topRightStep = origin + (player.forward, 1)
        if let previousMove = gameBoard.lastMove, previousMove.chessPiece.type == .pawn {
            if previousMove.move.source == topLeftStep + (player.forward, 0) && previousMove.move.destination == previousMove.move.source + (-player.forward * 2, 0) {
                moves.append(topLeftStep)
            }
            if previousMove.move.source == topRightStep + (player.forward, 0) && previousMove.move.destination == previousMove.move.source + (-player.forward * 2, 0) {
                moves.append(topRightStep)
            }
        }
        return moves
    }
}
