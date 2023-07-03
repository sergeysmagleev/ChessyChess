//
//  KnightMoveStrategyTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 09.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class KnightMoveStrategyTests: XCTestCase {
    
    func testKnightCanMoveToCorrectPositions() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "WN", "*", "*", "BN", "*", "*"],
            ["*", "BP", "WP", "WP", "WB", "*", "*", "*"],
            ["*", "BR", "WB", "WN", "WP", "*", "*", "*"],
            ["*", "*", "BR", "BB", "WQ", "*", "*", "*"],
            ["*", "*", "*", "*", "BN", "WP", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        let moves = Set(KnightMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(3, 1), (2, 4), (3, 5), (5, 5), (6, 4), (6, 2), (5, 1)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBishopCanMoveToCorrectPositionsFromCorner() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "WN", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(6, 1)
        let moves = Set(KnightMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(4, 0), (4, 2), (5, 3), (7, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBishopCanMoveToCorrectPositionsFromNoObstacles() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "WN", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 2)
        let moves = Set(KnightMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(3, 0), (2, 1), (2, 3), (3, 4), (5, 4), (6, 3), (6, 1), (5, 0)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
}

