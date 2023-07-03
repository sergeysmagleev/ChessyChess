//
//  QueenMoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class QueenMoveStrategy: MoveStrategy {
    
    let rookMoveStrategy = RookMoveStrategy()
    let bishopMoveStrategy = BishopMoveStrategy()
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        rookMoveStrategy.findEndCoordinates(gameBoard, origin: origin, player: player) + bishopMoveStrategy.findEndCoordinates(gameBoard, origin: origin, player: player)
    }
}
