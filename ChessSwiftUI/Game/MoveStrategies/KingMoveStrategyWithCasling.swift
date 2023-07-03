//
//  KingMoveStrategyWithCasling.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 13.05.23.
//

import Foundation

class KingMoveStrategyWithCastling: MoveStrategy {
    
    private let strategy = CombinedStrategy(stratA: KingMoveStrategy(), stratB: CastlingCheck(moveChecker: KingThreatStatusCheck()))
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        strategy.findEndCoordinates(gameBoard, origin: origin, player: player)
    }
}
