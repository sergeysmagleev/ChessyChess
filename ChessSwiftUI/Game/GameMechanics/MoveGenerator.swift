//
//  MoveGenerator.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation

class MoveGenerator {
    
    private var moveStrategies: [ChessPieceType: MoveStrategy] = [
        .pawn: PawnMoveStrategy(),
        .knight: KnightMoveStrategy(),
        .rook: RookMoveStrategy(),
        .bishop: BishopMoveStrategy(),
        .queen: QueenMoveStrategy(),
        .king: KingMoveStrategyWithCastling()
    ]
    private let moveChecker = MovePossibilityChecker()
    
    func listOfPossibleMoves(board: GameBoard, player: Player) -> [Move] {
        board.storage.enumerated().flatMap { (coordinate, cell) -> [Move] in
            guard case let .occupied(chessPiece) = cell,
                  chessPiece.player == player,
                  let moveStrategy = moveStrategies[chessPiece.type] else {
                return []
            }
            return moveStrategy.findEndCoordinates(board, origin: coordinate, player: player).map { destination in
                Move(source: coordinate, destination: destination)
            }
        }.filter { move in
            moveChecker.checkMovePossible(move, on: board)
        }
    }
    
}
