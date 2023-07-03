//
//  PawnMoveStrategy.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

class PawnMoveStrategy: MoveStrategy {
    
    func findEndCoordinates(_ gameBoard: GameBoard, origin: Coordinate, player: Player) -> [Coordinate] {
        guard case let .occupied(chessPiece) = gameBoard[origin] else {
            return []
        }
        var moves: [Coordinate] = []
        let oneStepForward = origin + (player.forward, 0)
        let twoStepsForward = origin + (player.forward * 2, 0)
        let topLeftStep = origin + (player.forward, -1)
        let topRightStep = origin + (player.forward, 1)
        if gameBoard.checkBoundaries(oneStepForward) && gameBoard[oneStepForward] == .empty {
            moves.append(oneStepForward)
            if gameBoard.checkBoundaries(twoStepsForward) && gameBoard[twoStepsForward] == .empty && !chessPiece.hasMoved {
                moves.append(twoStepsForward)
            }
        }
        if gameBoard.checkBoundaries(topLeftStep), case let .occupied(chessPiece) = gameBoard[topLeftStep], chessPiece.player == player.opponent {
            moves.append(topLeftStep)
        }
        if gameBoard.checkBoundaries(topRightStep), case let .occupied(chessPiece) = gameBoard[topRightStep], chessPiece.player == player.opponent {
            moves.append(topRightStep)
        }
        return moves + EnPassantCheck().findEndCoordinates(gameBoard, origin: origin, player: player)
    }
}
