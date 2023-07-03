//
//  GameBoard.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 06.05.23.
//

import Foundation

enum GameBoardError: Error {
    case kingIsMissing
}

struct GameBoard {
    var storage: Matrix<CellState>
    var lastMove: RecordedMove?
    
    init(storage: Matrix<CellState>) {
        self.storage = storage
    }
    
    func safeCheck(_ row: Int, _ col: Int) -> CellState? {
        guard row >= 0 && row < 8 && col >= 0 && col < 8 else {
            return nil
        }
        return storage[row, col]
    }
    
    func safeCheck(_ coordinate: Coordinate) -> CellState? {
        guard coordinate.row >= 0 && coordinate.row < 8 && coordinate.col >= 0 && coordinate.col < 8 else {
            return nil
        }
        return storage[coordinate.row, coordinate.col]
    }
    
    func checkBoundaries(_ coordinate: Coordinate) -> Bool {
        coordinate.row >= 0 && coordinate.row < 8 && coordinate.col >= 0 && coordinate.col < 8
    }
    
    func trace(from coordinate: Coordinate, by delta: (Int, Int), currentPlayer: Player) -> [Coordinate] {
        var coordinates: [Coordinate] = []
        var position = coordinate + delta
        while checkBoundaries(position) {
            if case let .occupied(chessPiece) = storage[position] {
                if chessPiece.player != currentPlayer {
                    coordinates.append(position)
                }
                break
            }
            coordinates.append(position)
            position = position + delta
        }
        return coordinates
    }
    
    subscript(row: Int, col: Int) -> CellState {
        storage[row, col]
    }
    
    subscript(coordinate: Coordinate) -> CellState {
        storage[coordinate]
    }
    
    mutating func makeMove(_ move: Move) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = storage.deepCopy()
        }
        guard checkBoundaries(move.source), checkBoundaries(move.destination),
              case var .occupied(chessPiece) = self[move.source] else {
            return
        }
        defer {
            lastMove = .init(chessPiece: chessPiece, move: move)
        }
        storage[move.source] = .empty
        if chessPiece.type == .king && !chessPiece.hasMoved && abs(move.source.col - move.destination.col) == 2 {
            if move.source.col > move.destination.col {
                storage[move.source.row, move.destination.col + 1] = storage[move.source.row, 0].moved()
                storage[move.source.row, 0] = .empty
            } else {
                storage[move.source.row, move.destination.col - 1] = storage[move.source.row, 7].moved()
                storage[move.source.row, 7] = .empty
            }
        }
        if chessPiece.type == .pawn && storage[move.destination] == .empty && abs(move.source.col - move.destination.col) == 1 {
            storage[move.destination.moveBy((-chessPiece.player.forward, 0))] = .empty
        }
        if chessPiece.type == .pawn && (move.destination.row == 0 || move.destination.row == 7) {
            chessPiece.type = .queen
        }
        storage[move.destination] = .occupied(chessPiece.moved())
    }
    
    func locateKing(player: Player) -> Coordinate? {
        for (coordinate, cell) in storage.enumerated() {
            guard case let .occupied(chessPiece) = cell else {
                continue
            }
            if chessPiece.player == player && chessPiece.type == .king {
                return coordinate
            }
        }
        return nil
    }
}

extension GameBoard {
    
    static func create(fromGrid grid: [[String]]) -> GameBoard? {
        var values: [CellState] = []
        values.reserveCapacity(64)
        guard grid.count == 8 else {
            return nil
        }
        for row in grid {
            guard row.count == 8 else {
                return nil
            }
            for cell in row {
                guard let cellState = parseTextRepresentation(cell) else {
                    return nil
                }
                values.append(cellState)
            }
        }
        return .init(storage: .init(rowsNum: 8, colsNum: 8, values: values))
    }
    
    static private func parseTextRepresentation(_ cell: String) -> CellState? {
        if cell.count == 1 {
            return .empty
        } else if cell.count == 2 {
            let characters = Array(cell)
            var player: Player = .white
            var piece: ChessPieceType = .pawn
            let hasMoved = characters[1].isUppercase
            switch characters[0].uppercased() {
            case "W":
                player = .white
            case "B":
                player = .black
            default:
                return nil
            }
            switch characters[1].uppercased() {
            case "P":
                piece = .pawn
            case "R":
                piece = .rook
            case "B":
                piece = .bishop
            case "N":
                piece = .knight
            case "K":
                piece = .king
            case "Q":
                piece = .queen
            default:
                return nil
            }
            return .occupied(.init(player: player, type: piece, hasMoved: hasMoved))
        } else {
            return nil
        }
    }
    
    static var initial: GameBoard {
        .create(fromGrid: [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ])!
    }
    
    func produceGrid() -> [[String]] {
        storage.rows.map { row in
            row.map { cell in
                switch cell {
                case .empty:
                    return "*"
                case let.occupied(chessPiece):
                    let player = chessPiece.player == .black ? "B" : "W"
                    let piece: String
                    switch chessPiece.type {
                    case .pawn:
                        piece = "p"
                    case .queen:
                        piece = "q"
                    case .king:
                        piece = "k"
                    case .bishop:
                        piece = "b"
                    case .knight:
                        piece = "n"
                    case .rook:
                        piece = "r"
                    }
                    return player + (chessPiece.hasMoved ? piece.uppercased() : piece)
                }
            }
        }
    }
}
