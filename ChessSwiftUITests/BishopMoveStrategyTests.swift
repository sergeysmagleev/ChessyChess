//
//  BishopMoveStrategyTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 09.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class BishopMoveStrategyTests: XCTestCase {
    
    func testBishopCanMoveToCorrectPositions() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "BN", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "WB", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "WP", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        let moves = Set(BishopMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(3, 2), (2, 1), (1, 0), (5, 2), (6, 1), (7, 0), (3, 4), (2, 5), (5, 4)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBishopCanMoveToCorrectPositionsFromCorner() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "*", "WP", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["WB", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(7, 0)
        let moves = Set(BishopMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(6, 1), (5, 2), (4, 3), (3, 4), (2, 5), (1, 6), (0, 7)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
    
    func testBishopCanMoveToCorrectPositionsFromBorder() {
        let textGrid = [
            ["*", "*", "WB", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "*", "WP", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(0, 2)
        let moves = Set(BishopMoveStrategy().findEndCoordinates(gameBoard, origin: origin, player: .white))
        let expectedMoves = Set([(1, 1), (2, 0), (1, 3)].map(Coordinate.init))
        XCTAssertEqual(moves, expectedMoves)
    }
}
