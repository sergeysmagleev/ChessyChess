//
//  RookMoveStrategyTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 09.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class RookMoveStrategyTests: XCTestCase {
    
    func testRookCanMoveToCorrectPositions() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "WR", "WP", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        let moves = Set(RookMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(4, 2), (4, 1), (3, 3), (2, 3), (1, 3), (5, 3), (6, 3), (7, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testRookCanMoveToCorrectPositionsFromCorner() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "WR", "WP", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["WR", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 0)
        let moves = Set(RookMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 0), (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
}
