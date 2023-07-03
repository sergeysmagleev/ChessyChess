//
//  GameData.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 28.04.23.
//

import Foundation

class GameData {
    
    private(set) var board: GameBoard
    private(set) var possibleMovesPerCoordinate: [Coordinate: Set<Move>] = [:]
    private(set) var selectedCoordinate: Coordinate?
    private(set) var currentPlayer: Player
    private(set) var currentState: GameState = .normal
    private(set) var possibleMoves: Set<Move> = []
    
    private let moveGenerator = MoveGenerator()
    private let stateChecker = GameStateChecker()
    
    var possibleMovesForSelectedPiece: Set<Move> {
        guard let selectedCoordinate = selectedCoordinate else {
            return []
        }
        return possibleMovesPerCoordinate[selectedCoordinate] ?? []
    }
    
    init(board: GameBoard, player: Player, selectedCoordinate: Coordinate? = nil) {
        self.board = board
        self.currentPlayer = player
        self.selectedCoordinate = selectedCoordinate
        updateGameState()
    }
    
    func selectCell(row: Int, col: Int) {
        let coordinate: Coordinate = .init(row, col)
        if case let .occupied(chessPiece) = board[coordinate], chessPiece.player == currentPlayer {
            selectedCoordinate = coordinate
        } else {
            guard let selectedCoordinate = selectedCoordinate else {
                return
            }
            let expectedMove: Move = .init(source: selectedCoordinate, destination: coordinate)
            guard possibleMovesForSelectedPiece.contains(expectedMove) else {
                return
            }
            board.makeMove(expectedMove)
            finishMoveAndUpdateGameState()
        }
    }
    
    private func findAllPossibleMoves() {
        possibleMoves = Set(moveGenerator
            .listOfPossibleMoves(board: board, player: currentPlayer))
        possibleMovesPerCoordinate = possibleMoves
            .reduce(into: [:]) { dict, move in dict[move.source, default: []].insert(move) }
    }
    
    func isKingThatIsUnderThread(at coordinate: Coordinate) -> Bool {
        guard case let .occupied(chessPiece) = board[coordinate] else {
            return false
        }
        return chessPiece.player == currentPlayer && chessPiece.type == .king && (currentState == .check || currentState == .checkmate)
    }
    
    private func updateGameState() {
        findAllPossibleMoves()
        currentState = stateChecker.checkState(board: board, player: currentPlayer)
    }
    
    private func finishMoveAndUpdateGameState() {
        currentPlayer.toggle()
        selectedCoordinate = nil
        updateGameState()
    }

}
