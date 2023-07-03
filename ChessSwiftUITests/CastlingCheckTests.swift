//
//  CastlingCheckTEst.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 13.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class CastlingCheckTests: XCTestCase {
    
    func testCastlingNotPossibleBecauseRookMoved() {
        let textGrid = [
            ["BR", "*", "*", "*", "Bk", "Bb", "Bn", "Br"],
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
        let origin = Coordinate(0, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(0, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testCastlingNotPossibleBecauseKingMoved() {
        let textGrid = [
            ["Br", "*", "*", "*", "BK", "Bb", "Bn", "Br"],
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
        let origin = Coordinate(0, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(0, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackEligibleForLeftCastling() {
        let textGrid = [
            ["Br", "*", "*", "*", "Bk", "Bb", "Bn", "Br"],
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
        let origin = Coordinate(0, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(0, 3), (0, 2)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackEligibleForRightCastling() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "*", "*", "Br"],
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
        let origin = Coordinate(0, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(0, 5), (0, 6)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackEligibleForBothCastling() {
        let textGrid = [
            ["Br", "*", "*", "*", "Bk", "*", "*", "Br"],
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
        let origin = Coordinate(0, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(0, 3), (0, 2), (0, 5), (0, 6)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteEligibleForLeftCastling() {
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
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 3), (7, 2)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteEligibleForRightCastling() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "*", "*", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 6)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteEligibleForBothCastling() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 2), (7, 3), (7, 5), (7, 6)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testLeftCastlingNotPossibleBecauseKingIsUnderAttackMidway() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "*", "*", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 6), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testRightCastlingNotPossibleBecauseKingIsUnderAttackMidway() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "BR", "*", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 2), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testLeftCastlingNotPossibleBecauseKingIsUnderAttack() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "BR", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 6), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testRightCastlingNotPossibleBecauseKingIsUnderAttack() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "BR", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 2), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testNoCastlingPossibleBecauseRowIsUnderAttack() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "BR", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "BQ"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testNoCastlingPossibleBecauseKingIsUnderAttack() {
        let textGrid = [
            ["*", "BK", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BR", "*", "*", "*"],
            ["*", "BR", "*", "*", "*", "*", "*", "*"],
            ["Wr", "*", "*", "*", "Wk", "*", "*", "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 4)
        let moves = Set(KingMoveStrategyWithCastling().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(7, 5), (7, 3), (6, 3), (6, 4), (6, 5)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
}
