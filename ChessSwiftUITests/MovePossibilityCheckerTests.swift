//
//  MovePossibilityCheckerTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 20.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class MovePossibilityCheckerTests: XCTestCase {
    
    func testStartingMoves() {
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
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let allowedMoves: [Move] = [
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
        allowedMoves.forEach { move in
            XCTAssertTrue(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
        }
    }
    
    func testMoveIsNonThreatening() {
        let textGrid = [
            ["Br", "Bn", "Bb", "*", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BQ", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(6, 4), destination: .init(4, 4))
        XCTAssertTrue(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
    func testMoveExposesKing() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "BR", "BR", "*", "*", "*", "*"],
            ["*", "*", "*", "WP", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(2, 3), destination: .init(1, 2))
        XCTAssertFalse(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
    func testMoveDoesntExposeKing() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "BR", "BR", "*", "*", "BQ", "*"],
            ["*", "*", "*", "WP", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "WB", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(3, 4), destination: .init(2, 5))
        XCTAssertTrue(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
    func testKingUnderAttackByKnight() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "BR", "BR", "*", "*", "BQ", "*"],
            ["*", "*", "*", "WP", "BN", "*", "*", "*"],
            ["*", "*", "*", "*", "WB", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(3, 4), destination: .init(2, 5))
        XCTAssertFalse(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
    func testKingExposesHimself() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "BR", "BR", "*", "BQ", "*", "*"],
            ["*", "*", "*", "WP", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "WB", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(4, 3), destination: .init(3, 3))
        XCTAssertFalse(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
    func testCastlingNotPossible() {
        let textGrid = [
            ["Br", "Bn", "Bb", "*", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "BQ", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "*", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let move: Move = .init(source: .init(7, 4), destination: .init(4, 2))
        XCTAssertFalse(MovePossibilityChecker().checkMovePossible(move, on: gameBoard))
    }
    
}
