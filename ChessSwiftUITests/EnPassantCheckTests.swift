//
//  EnPassantCheckTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 13.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class EnPassantCheckTests: XCTestCase {
    
    func testEnPassantPossible() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "WP", "BP", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.lastMove = .init(chessPiece: .init(player: .white, type: .pawn, hasMoved: true), move: .init(source: .init(6, 1), destination: .init(4, 1)))
        let origin = Coordinate(4, 2)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(5, 2), (5, 1)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testEnPassantNotPossibleBecauseOfLastMove() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "WP", "BP", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.lastMove = nil
        let origin = Coordinate(4, 2)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(5, 2)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testEnPassantNotPossibleBecauseOfCoordinates() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["WP", "*", "BP", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard var gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        gameBoard.lastMove = .init(chessPiece: .init(player: .white, type: .pawn, hasMoved: true), move: .init(source: .init(6, 0), destination: .init(4, 0)))
        let origin = Coordinate(4, 2)
        let moves = Set(PawnMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .black))
        let expectedMoves = Set([(5, 2)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
}
