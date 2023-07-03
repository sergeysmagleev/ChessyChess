//
//  PawnMoveStrategyCheck.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 13.05.23.
//

import XCTest
@testable import ChessSwiftUI

class PawnMoveStrategyTests: XCTestCase {
    
    func testBlackMovesFromStartingPosition() {
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
        let origin = Coordinate(1, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(2, 1), (3, 1)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteMovesFromStartingPosition() {
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
        let origin = Coordinate(6, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(5, 1), (4, 1)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackMovesFromOtherPosition() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["*", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["BP", "BP", "*", "*", "*", "*", "*", "*"],
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
        let origin = Coordinate(2, 0)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(3, 0)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteMovesFromOtherPosition() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "WP"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "*"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(5, 7)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(4, 7)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackBlockedByOwnPlayer() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["*", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "BP", "*", "*", "*", "*", "*", "*"],
            ["*", "BP", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(2, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteBlockedByOwnPlayer() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "WP"],
            ["*", "*", "*", "*", "*", "*", "*", "WP"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "*", "*"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(5, 7)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackBlockedFromStartingPosition() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "WP", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "*", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(1, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(2, 1)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteBlockedFromStartingPosition() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "*", "Bp", "Bp", "Bp", "Bp"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BP", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(6, 3)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(5, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackBlockedByOpponent() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["*", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["BP", "BP", "*", "*", "*", "*", "*", "*"],
            ["*", "WP", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["Wp", "*", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(2, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteBlockedByOpponent() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "BP"],
            ["*", "*", "*", "*", "*", "*", "*", "WP"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "*"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(5, 7)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBlackCapturing() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["*", "*", "Bp", "Bp", "Bp", "Bp", "Bp", "Bp"],
            ["BP", "BP", "*", "*", "*", "*", "*", "*"],
            ["WP", "WP", "WP", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "Wp", "Wp", "Wp", "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(2, 1)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(3, 0), (3, 2)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testWhiteCapturing() {
        let textGrid = [
            ["Br", "Bn", "Bb", "Bq", "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "Bp", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "BP", "BP", "BP"],
            ["*", "*", "*", "*", "*", "*", "WP", "*"],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "Wp", "*", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(5, 6)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(4, 5), (4, 7)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
}
