//
//  CastlingCheck.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 09.05.23.
//

import Foundation

class CastlingCheck: MoveStrategy {
    
    private let moveChecker: KingThreatStatusCheck
    
    init(moveChecker: KingThreatStatusCheck) {
        self.moveChecker = moveChecker
    }
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        guard case let .occupied(chessPiece) = gameBoard[origin], chessPiece.type == .king, !chessPiece.hasMoved else {
            return []
        }
        return checkLeftCastling(gameBoard, origin: origin, player: player) + checkRightCastling(gameBoard, origin: origin, player: player)
    }
    
    func checkLeftCastling(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        let row = origin.row
        guard case let .occupied(chessPiece) = gameBoard[row, 0], chessPiece.type == .rook, !chessPiece.hasMoved else {
            return []
        }
        guard moveChecker.isKingSafe(gameBoard, origin: origin, player: player) &&
                checkKingSafety(gameBoard, at: origin - (0, 1), kingAt: origin, player: player) &&
                checkKingSafety(gameBoard, at: origin - (0, 2), kingAt: origin, player: player) else {
            return []
        }
        for i in 1 ..< origin.col {
            if gameBoard[row, i] != .empty {
                return []
            }
        }
        return [origin - (0, 2)]
    }
    
    func checkRightCastling(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        let row = origin.row
        guard case let .occupied(chessPiece) = gameBoard[row, 7], chessPiece.type == .rook, !chessPiece.hasMoved else {
            return []
        }
        guard moveChecker.isKingSafe(gameBoard, origin: origin, player: player) &&
                checkKingSafety(gameBoard, at: origin + (0, 1), kingAt: origin, player: player) &&
                checkKingSafety(gameBoard, at: origin + (0, 2), kingAt: origin, player: player) else {
            return []
        }
        for i in origin.col + 1 ..< 7 {
            if gameBoard[row, i] != .empty {
                return []
            }
        }
        return [origin + (0, 2)]
    }
    
    private func checkKingSafety(_ gameBoard: GameBoard, at destination: Coordinate, kingAt origin: Coordinate, player: Player) -> Bool {
        var afterMove = gameBoard
        afterMove.makeMove(.init(source: origin, destination: destination))
        return moveChecker.isKingSafe(afterMove, origin: destination, player: player)
    }
}
