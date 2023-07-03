//
//  GameGrid.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 28.04.23.
//

import Foundation
import UIKit

class GameGrid: ObservableObject {
    
    @Published var grid: [GameGridRow] = []
    @Published var winnerText: String = ""
    static var columnNames: [String] = ["", "A", "B", "C", "D", "E", "F", "G", "H"]
    private var gameData: GameData
    
    init(gameData: GameData = GameData(board: .initial, player: .white)) {
        self.gameData = gameData
        render()
    }
    
    func selectCell(_ row: Int, _ col: Int) {
        gameData.selectCell(row: row, col: col)
        render()
    }
    
    func render() {
        grid = (0 ..< gameData.board.storage.rowsNum).map { i in
            GameGridRow(rowNumber: 8 - i, viewModels: (0 ..< gameData.board.storage.colsNum).map { j in
                ViewModel(value: playerText(gameData.board[i, j]),
                          pieceColor: pieceColor(gameData.board[i, j]),
                          backgroundColor: cellColor(at: .init(i, j)),
                          borderColor: borderColor(at: .init(i, j)),
                          icon: cellIcon(gameData.board[i, j])) { [weak self] in
                    self?.selectCell(i, j)
                }
            })
        }
    }
    
    func playerText(_ cellState: CellState) -> String {
        guard case let .occupied(piece) = cellState else {
            return ""
        }
        switch piece.type {
        case .pawn:
            return piece.player == .white ? "♙" : "♟︎"
        case .rook:
            return piece.player == .white ? "♖" : "♜"
        case .knight:
            return piece.player == .white ? "♘" : "♞"
        case .bishop:
            return piece.player == .white ? "♗" : "♝"
        case .queen:
            return piece.player == .white ? "♕" : "♛"
        case .king:
            return piece.player == .white ? "♔" : "♚"
        }
        
    }
    
    func pieceColor(_ cellState: CellState) -> UIColor {
        guard case let .occupied(piece) = cellState else {
            return .gray
        }
        return piece.player == .white ? .white : .black
    }
    
    func borderColor(at coordinate: Coordinate) -> UIColor {
        if gameData.possibleMoves.map({ $0.source }).contains(coordinate) {
            return .fromHex("#00433F")
        }
        return .clear
    }
    
    func cellColor(at coordinate: Coordinate) -> UIColor {
        if gameData.selectedCoordinate == coordinate {
            return .fromHex("#f19e93")
        }
        if gameData.possibleMovesForSelectedPiece.map({ $0.destination }).contains(coordinate) {
            return .fromHex("#81d4fa")
        }
        if gameData.isKingThatIsUnderThread(at: coordinate) {
            return .fromHex("#f13a37")
        }
        return (coordinate.col + coordinate.row) % 2 == 0 ? .fromHex("#d7ccc8") : .fromHex("#a1887f")
    }
    
    func cellIcon(_ cellState: CellState) -> UIImage? {
        guard case let .occupied(piece) = cellState else {
            return nil
        }
        switch (piece.player, piece.type) {
        case (.black, .pawn):
            return .init(named: "black-pawn")
        case (.black, .rook):
            return .init(named: "black-rook")
        case (.black, .knight):
            return .init(named: "black-knight")
        case (.black, .bishop):
            return .init(named: "black-bishop")
        case (.black, .king):
            return .init(named: "black-king")
        case (.black, .queen):
            return .init(named: "black-queen")
        case (.white, .pawn):
            return .init(named: "white-pawn")
        case (.white, .rook):
            return .init(named: "white-rook")
        case (.white, .knight):
            return .init(named: "white-knight")
        case (.white, .bishop):
            return .init(named: "white-bishop")
        case (.white, .king):
            return .init(named: "white-king")
        case (.white, .queen):
            return .init(named: "white-queen")
        }
    }
}
