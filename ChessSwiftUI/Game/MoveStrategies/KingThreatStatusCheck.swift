//
//  KingThreatStatusCheck.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class KingThreatStatusCheck {
    
    func isKingSafe(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        checkLateralThreat(gameBoard, origin: origin, player: player) &&
        checkDiagonalThreat(gameBoard, origin: origin, player: player) &&
        checkPawnThreat(gameBoard, origin: origin, player: player) &&
        checkKingThreat(gameBoard, origin: origin, player: player) &&
        checkKnightThreat(gameBoard, origin: origin, player: player)
    }
    
    func isKingUnderAttack(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        !isKingSafe(gameBoard, origin: origin, player: player)
    }
    
    private func checkLateralThreat(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        RookMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: player)
            .map { gameBoard[$0] }
            .compactMap { $0.chessPiece }
            .filter { $0.type == .rook || $0.type == .queen }
            .isEmpty
    }
    
    private func checkDiagonalThreat(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        BishopMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: player)
            .map { gameBoard[$0] }
            .compactMap { $0.chessPiece }
            .filter { $0.type == .bishop || $0.type == .queen }
            .isEmpty
    }
    
    private func checkPawnThreat(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        let topLeft = origin + (player.forward, -1)
        if gameBoard.checkBoundaries(topLeft), let chessPiece = gameBoard[topLeft].chessPiece {
            if chessPiece.type == .pawn && chessPiece.player == player.opponent {
                return false
            }
        }
        let topRight = origin + (player.forward, 1)
        if gameBoard.checkBoundaries(topRight), let chessPiece = gameBoard[topRight].chessPiece {
            if chessPiece.type == .pawn && chessPiece.player == player.opponent {
                return false
            }
        }
        return true
    }
    
    private func checkKingThreat(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        KingMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: player)
            .map { gameBoard[$0] }
            .compactMap { $0.chessPiece }
            .filter { $0.type == .king }
            .isEmpty
    }
    
    private func checkKnightThreat(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> Bool {
        KnightMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: player)
            .map { gameBoard[$0] }
            .compactMap { $0.chessPiece }
            .filter { $0.type == .knight }
            .isEmpty
    }
    
}
