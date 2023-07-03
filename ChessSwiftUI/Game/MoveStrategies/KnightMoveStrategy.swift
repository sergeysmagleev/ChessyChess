//
//  KnightMoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class KnightMoveStrategy: MoveStrategy {
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        [
            (1, 2), (1, -2), (-1, 2), (-1, -2),
            (2, 1), (2, -1), (-2, 1), (-2, -1)
        ]
            .map { origin + $0 }
            .filter { gameBoard.checkBoundaries($0) }
            .filter { coordinate in
                let cellState = gameBoard[coordinate]
                switch cellState {
                case .empty:
                    return true
                case let .occupied(chessPiece):
                    return chessPiece.player == player.opponent
                }
            }
    }
}
