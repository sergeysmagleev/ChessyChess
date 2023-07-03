//
//  RookMoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class RookMoveStrategy: MoveStrategy {
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        [(0, 1), (0, -1), (1, 0), (-1, 0)]
            .map { gameBoard.trace(from: origin, by: $0, currentPlayer: player) }
            .flatMap { $0 }
    }
}
