//
//  CombinedStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 13.05.23.
//

import Foundation

class CombinedStrategy: MoveStrategy {
    
    private var stratA: MoveStrategy
    private var stratB: MoveStrategy
    
    init(stratA: MoveStrategy, stratB: MoveStrategy) {
        self.stratA = stratA
        self.stratB = stratB
    }
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        stratA.findEndCoordinates(gameBoard, origin: origin, player: player) + stratB.findEndCoordinates(gameBoard, origin: origin, player: player)
    }
}
