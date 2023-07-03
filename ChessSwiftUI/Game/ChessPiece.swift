//
//  ChessPiece.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import Foundation

enum ChessPieceType: CustomStringConvertible {
    case pawn, rook, bishop, knight, king, queen
    
    var description: String {
        switch self {
        case .pawn:
            return "pawn"
        case .rook:
            return "rook"
        case .bishop:
            return "bishop"
        case .knight:
            return "knight"
        case .king:
            return "king"
        case .queen:
            return "queen"
        }
    }
}

struct ChessPiece: Equatable {
    var player: Player
    var type: ChessPieceType
    var hasMoved = false
    
    func moved() -> Self {
        var updated = self
        updated.hasMoved = true
        return updated
    }
}
