//
//  MoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

protocol MoveStrategy {
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate]
}
