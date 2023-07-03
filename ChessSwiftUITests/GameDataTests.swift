//
//  GameDataTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 22.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class GameStateTests: XCTestCase {
    
    // no item is selected
    func testSelectFriendlyPiece() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white)
        gameData.selectCell(row: 4, col: 2)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, .init(4, 2))
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [.init(source: .init(4, 2), destination: .init(3, 2))])
        XCTAssertEqual(gameData.board.produceGrid(), textGrid)
        XCTAssertEqual(gameData.currentState, .normal)
    }
    
    func testTrySelectOpponentPiece() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white)
        gameData.selectCell(row: 0, col: 4)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.board.produceGrid(), textGrid)
        XCTAssertEqual(gameData.currentState, .normal)
    }
    
    func testSelectEmptySpot() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white)
        gameData.selectCell(row: 3, col: 4)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.board.produceGrid(), textGrid)
        XCTAssertEqual(gameData.currentState, .normal)
    }
    
    // a piece is selected
    func testAttemptToMoveToInvalidSpot() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white, selectedCoordinate: .init(4, 3))
        gameData.selectCell(row: 3, col: 2)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, .init(4, 3))
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [.init(source: .init(4, 3), destination: .init(3, 3))])
        XCTAssertEqual(gameData.board.produceGrid(), textGrid)
        XCTAssertEqual(gameData.currentState, .normal)
    }
    
    func testMoveToEmptySpot() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white, selectedCoordinate: .init(4, 3))
        gameData.selectCell(row: 3, col: 3)
        XCTAssertEqual(gameData.currentPlayer, .black)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.currentState, .normal)
        let expectedGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "WP", "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "*",  "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        XCTAssertEqual(gameData.board.produceGrid(), expectedGrid)
    }
    
    func testCaptureEnemyPiece() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .white, selectedCoordinate: .init(3, 5))
        gameData.selectCell(row: 1, col: 6)
        XCTAssertEqual(gameData.currentPlayer, .black)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.currentState, .normal)
        let expectedGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "WN", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        XCTAssertEqual(gameData.board.produceGrid(), expectedGrid)
    }
    
    func testCheck() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "WN", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .black, selectedCoordinate: .init(6, 7))
        gameData.selectCell(row: 7, col: 7)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.currentState, .check)
        let expectedGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "WN", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "*" ],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "BQ"]
        ]
        XCTAssertEqual(gameData.board.produceGrid(), expectedGrid)
    }
    
    func testCheckmate() {
        let textGrid = [
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Bp", "*",  "*",  "*",  "WQ", "BN", "BK", "*" ],
            ["BR", "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "*",  "BN", "*",  "*",  "WK"],
            ["*",  "*",  "*",  "*",  "WP", "*",  "*",  "WP"],
            ["Wp", "*",  "*",  "*",  "*",  "BR", "Wp", "*" ],
            ["*",  "*",  "*",  "BB", "*",  "WB", "*",  "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .black, selectedCoordinate: .init(2, 0))
        gameData.selectCell(row: 2, col: 7)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.currentState, .checkmate)
        let expectedGrid = [
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Bp", "*",  "*",  "*",  "WQ", "BN", "BK", "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "BR"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "*",  "BN", "*",  "*",  "WK"],
            ["*",  "*",  "*",  "*",  "WP", "*",  "*",  "WP"],
            ["Wp", "*",  "*",  "*",  "*",  "BR", "Wp", "*" ],
            ["*",  "*",  "*",  "BB", "*",  "WB", "*",  "Wr"]
        ]
        XCTAssertEqual(gameData.board.produceGrid(), expectedGrid)
    }
    
    func testStalemate() {
        let textGrid = [
            ["BK", "*",  "*",  "BR", "*",  "*",  "*",  "BR" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "BQ", "*" ],
            ["*",  "*",  "*",  "*",  "WK", "*",  "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let gameData = GameData(board: gameBoard, player: .black, selectedCoordinate: .init(0, 7))
        gameData.selectCell(row: 0, col: 5)
        XCTAssertEqual(gameData.currentPlayer, .white)
        XCTAssertEqual(gameData.selectedCoordinate, nil)
        XCTAssertEqual(gameData.possibleMovesForSelectedPiece, [])
        XCTAssertEqual(gameData.currentState, .stalemate)
        let expectedGrid = [
            ["BK", "*",  "*",  "BR", "*",  "BR", "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "BQ", "*" ],
            ["*",  "*",  "*",  "*",  "WK", "*",  "*",  "*" ]
        ]
        XCTAssertEqual(gameData.board.produceGrid(), expectedGrid)
    }
    
}
