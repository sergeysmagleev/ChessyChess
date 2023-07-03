//
//  MakingMoveTest.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 13.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class MakingMoveTests: XCTestCase {
    
    func testMakeKnightMove() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.makeMove(.init(source: .init(0, 1), destination: .init(2, 2)))
        let expectedGrid = [
            ["Br", "*", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "BN", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
    
    func testEnPassantMove() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BP", "WP", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "*", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let previousMove: Move = .init(source: .init(1, 1), destination: .init(3, 1))
        gameBoard.lastMove = .init(chessPiece: .init(player: .black, type: .pawn), move: previousMove)
        gameBoard.makeMove(.init(source: .init(3, 2), destination: .init(2, 1)))
        let expectedGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "WP", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "*", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
    
    func testCastlingMove() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "*", "*", "*", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.makeMove(.init(source: .init(7, 4), destination: .init(7, 2)))
        let expectedGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["*", "*", "WK", "WR", "*", "Wb", "Wn", "Wr"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
    
    func testKnightCapture() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "WB", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "*", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.makeMove(.init(source: .init(0, 1), destination: .init(2, 2)))
        let expectedGrid = [
            ["Br", "*", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "BN", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "*", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
    
    func testPawnPromotion() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "WP", "*", "*", "BK", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.makeMove(.init(source: .init(1, 2), destination: .init(0, 2)))
        let expectedGrid = [
            ["*", "*", "WQ", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "BK", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
    
    func testPawnPromotionWhenQueenExists() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "WP", "*", "*", "BK", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BQ", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "BP", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.makeMove(.init(source: .init(6, 5), destination: .init(7, 5)))
        let expectedGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "WP", "*", "*", "BK", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BQ", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "BQ", "*", "*"]
        ]
        XCTAssertEqual(gameBoard.produceGrid(), expectedGrid)
    }
}

