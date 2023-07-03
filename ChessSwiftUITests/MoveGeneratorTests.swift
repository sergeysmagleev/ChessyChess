//
//  MoveGeneratorTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class MoveGeneratorTests: XCTestCase {
    
    func testGenerateStartingMovesForWhite() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        let expectedMoves: [Move] = [
            .init(source: .init(6, 0), destination: .init(5, 0)),
            .init(source: .init(6, 0), destination: .init(4, 0)),
            .init(source: .init(6, 1), destination: .init(5, 1)),
            .init(source: .init(6, 1), destination: .init(4, 1)),
            .init(source: .init(6, 2), destination: .init(5, 2)),
            .init(source: .init(6, 2), destination: .init(4, 2)),
            .init(source: .init(6, 3), destination: .init(5, 3)),
            .init(source: .init(6, 3), destination: .init(4, 3)),
            .init(source: .init(6, 4), destination: .init(5, 4)),
            .init(source: .init(6, 4), destination: .init(4, 4)),
            .init(source: .init(6, 5), destination: .init(5, 5)),
            .init(source: .init(6, 5), destination: .init(4, 5)),
            .init(source: .init(6, 6), destination: .init(5, 6)),
            .init(source: .init(6, 6), destination: .init(4, 6)),
            .init(source: .init(6, 7), destination: .init(5, 7)),
            .init(source: .init(6, 7), destination: .init(4, 7)),
            .init(source: .init(7, 1), destination: .init(5, 0)),
            .init(source: .init(7, 1), destination: .init(5, 2)),
            .init(source: .init(7, 6), destination: .init(5, 5)),
            .init(source: .init(7, 6), destination: .init(5, 7))
        ]
        XCTAssertEqual(moves.count, expectedMoves.count)
        XCTAssertEqual(Set(moves), Set(expectedMoves))
    }
    
    func testGenerateStartingMovesForBlack() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .black)
        let expectedMoves: [Move] = [
            .init(source: .init(1, 0), destination: .init(2, 0)),
            .init(source: .init(1, 0), destination: .init(3, 0)),
            .init(source: .init(1, 1), destination: .init(2, 1)),
            .init(source: .init(1, 1), destination: .init(3, 1)),
            .init(source: .init(1, 2), destination: .init(2, 2)),
            .init(source: .init(1, 2), destination: .init(3, 2)),
            .init(source: .init(1, 3), destination: .init(2, 3)),
            .init(source: .init(1, 3), destination: .init(3, 3)),
            .init(source: .init(1, 4), destination: .init(2, 4)),
            .init(source: .init(1, 4), destination: .init(3, 4)),
            .init(source: .init(1, 5), destination: .init(2, 5)),
            .init(source: .init(1, 5), destination: .init(3, 5)),
            .init(source: .init(1, 6), destination: .init(2, 6)),
            .init(source: .init(1, 6), destination: .init(3, 6)),
            .init(source: .init(1, 7), destination: .init(2, 7)),
            .init(source: .init(1, 7), destination: .init(3, 7)),
            .init(source: .init(0, 1), destination: .init(2, 0)),
            .init(source: .init(0, 1), destination: .init(2, 2)),
            .init(source: .init(0, 6), destination: .init(2, 5)),
            .init(source: .init(0, 6), destination: .init(2, 7))
        ]
        XCTAssertEqual(moves.count, expectedMoves.count)
        XCTAssertEqual(Set(moves), Set(expectedMoves), setDiffPrintout(Set(moves), Set(expectedMoves)))
    }
    
    func testGenerateMovesWithChanceOfExposingKing() {
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
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        let expectedMoves: [Move] = [
            //pawns
            .init(source: .init(6, 0), destination: .init(5, 0)),
            .init(source: .init(6, 0), destination: .init(4, 0)),
            .init(source: .init(4, 2), destination: .init(3, 2)),
            .init(source: .init(4, 3), destination: .init(3, 3)),
            //knight 1
            .init(source: .init(2, 2), destination: .init(1, 0)),
            .init(source: .init(2, 2), destination: .init(0, 1)),
            .init(source: .init(2, 2), destination: .init(0, 3)),
            .init(source: .init(2, 2), destination: .init(1, 4)),
            .init(source: .init(2, 2), destination: .init(3, 0)),
            .init(source: .init(2, 2), destination: .init(3, 4)),
            .init(source: .init(2, 2), destination: .init(4, 1)),
            //knight 2
            .init(source: .init(3, 5), destination: .init(1, 4)),
            .init(source: .init(3, 5), destination: .init(1, 6)),
            .init(source: .init(3, 5), destination: .init(2, 7)),
            .init(source: .init(3, 5), destination: .init(4, 7)),
            .init(source: .init(3, 5), destination: .init(5, 6)),
            .init(source: .init(3, 5), destination: .init(5, 4)),
            //bishop walking on black
            .init(source: .init(2, 3), destination: .init(1, 2)),
            .init(source: .init(2, 3), destination: .init(0, 1)),
            .init(source: .init(2, 3), destination: .init(3, 4)),
            .init(source: .init(2, 3), destination: .init(4, 5)),
            .init(source: .init(2, 3), destination: .init(1, 4)),
            .init(source: .init(2, 3), destination: .init(0, 5)),
            .init(source: .init(2, 3), destination: .init(3, 2)),
            .init(source: .init(2, 3), destination: .init(4, 1)),
            .init(source: .init(2, 3), destination: .init(5, 0)),
            //bishop walking on white
            .init(source: .init(6, 6), destination: .init(7, 7)),
            .init(source: .init(6, 6), destination: .init(5, 5)),
            .init(source: .init(6, 6), destination: .init(4, 4)),
            .init(source: .init(6, 6), destination: .init(3, 3)),
            .init(source: .init(6, 6), destination: .init(5, 7)),
            //rook 1
            .init(source: .init(7, 0), destination: .init(7, 1)),
            .init(source: .init(7, 0), destination: .init(7, 2)),
            //rook 2
            .init(source: .init(7, 3), destination: .init(7, 2)),
            .init(source: .init(7, 3), destination: .init(7, 1)),
            .init(source: .init(7, 3), destination: .init(7, 4)),
            .init(source: .init(7, 3), destination: .init(6, 3)),
            .init(source: .init(7, 3), destination: .init(5, 3)),
            //queen
            .init(source: .init(5, 1), destination: .init(4, 0)),
            .init(source: .init(5, 1), destination: .init(6, 2)),
            .init(source: .init(5, 1), destination: .init(4, 1)),
            .init(source: .init(5, 1), destination: .init(3, 1)),
            .init(source: .init(5, 1), destination: .init(2, 1)),
            .init(source: .init(5, 1), destination: .init(1, 1)),
            .init(source: .init(5, 1), destination: .init(0, 1)),
            .init(source: .init(5, 1), destination: .init(6, 1)),
            .init(source: .init(5, 1), destination: .init(7, 1)),
            .init(source: .init(5, 1), destination: .init(5, 0)),
            .init(source: .init(5, 1), destination: .init(5, 2)),
            .init(source: .init(5, 1), destination: .init(5, 3)),
            .init(source: .init(5, 1), destination: .init(5, 4)),
            //king
            .init(source: .init(7, 5), destination: .init(7, 4))
        ]
        XCTAssertEqual(moves.count, expectedMoves.count)
        XCTAssertEqual(Set(moves), Set(expectedMoves), setDiffPrintout(Set(moves), Set(expectedMoves)))
    }
    
    func testGenerateMovesUnderPreventableCheck() {
        let textGrid = [
            ["Br", "Bn", "Bb", "*",  "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "*",  "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "BP", "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "BQ"],
            ["*",  "*",  "*",  "*",  "*",  "WP", "*",  "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "*",  "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        let expectedMoves: [Move] = [
            .init(source: .init(6, 6), destination: .init(5, 6))
        ]
        XCTAssertEqual(moves.count, expectedMoves.count)
        XCTAssertEqual(Set(moves), Set(expectedMoves))
    }
    
    func testGenerateMovesUnderKnightCheck() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "*",  "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*", "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "*",  "BN", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "WN", "*",  "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        let expectedMoves: [Move] = [
            .init(source: .init(7, 4), destination: .init(6, 5))
        ]
        XCTAssertEqual(moves.count, expectedMoves.count)
        XCTAssertEqual(Set(moves), Set(expectedMoves))
    }
    
    func testGenerateMovesUnderCheckmate() {
        let textGrid = [
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Bp", "*",  "*",  "*",  "WQ", "BN", "BK", "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "BR"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "*",  "BN", "*",  "*",  "WK"],
            ["*",  "*",  "*",  "*",  "WP", "*",  "*",  "WP"],
            ["Wp", "*",  "*",  "*",  "*",  "BR", "Wp", "*" ],
            ["*",  "*",  "*",  "BB", "*",  "WB", "*",  "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        XCTAssertTrue(moves.isEmpty)
    }
    
    func testGenerateMovesUnderStalemate() {
        let textGrid = [
            ["BK", "*",  "*",  "BR", "*",  "BR", "*",  "*" ],
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
        let moves = MoveGenerator().listOfPossibleMoves(board: gameBoard, player: .white)
        XCTAssertTrue(moves.isEmpty)
    }
    
}
