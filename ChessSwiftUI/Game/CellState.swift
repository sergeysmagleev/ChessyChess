//
//  CellState.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import Foundation

enum CellState: Equatable {
    case empty
    case occupied(ChessPiece)
    
    enum Cases {
        case empty
        case occupied
    }
    
    var currentCase: Cases {
        switch self {
        case .empty:
            return .empty
        case .occupied:
            return .occupied
        }
    }
    
    func moved() -> Self {
        switch self {
        case .empty:
            return self
        case let .occupied(chessPiece):
            return .occupied(chessPiece.moved())
        }
    }
    
    var chessPiece: ChessPiece? {
        guard case let .occupied(chessPiece) = self else {
            return nil
        }
        return chessPiece
    }
}
