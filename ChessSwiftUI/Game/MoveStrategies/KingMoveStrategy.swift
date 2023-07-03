//
//  KingMoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class KingMoveStrategy: MoveStrategy {
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        [
            (1, 0), (-1, 0), (0, 1), (0, -1),
            (1, 1), (1, -1), (-1, 1), (-1, -1)
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
