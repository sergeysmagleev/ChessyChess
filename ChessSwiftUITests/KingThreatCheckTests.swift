//
//  KingThreatCheckTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 15.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class KingThreatCheckTests: XCTestCase {
    
    func testKingUnderThreatFromPawn() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "BP", "*", "*"],
            ["*", "*", "*", "*", "WK", "*", "*", "*"],
            ["*", "*", "*", "BN", "BB", "*", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingUnderThreatFromKnight() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "BP", "BP", "*", "*"],
            ["*", "*", "*", "BP", "WK", "BP", "*", "*"],
            ["*", "*", "BN", "BP", "BB", "BP", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingUnderThreatFromRook() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "*", "*", "*"],
            ["BR", "*", "*", "*", "WK", "*", "*", "*"],
            ["*", "*", "*", "BN", "BB", "*", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingUnderThreatFromBishop() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "WK", "*", "*", "*"],
            ["*", "*", "*", "BN", "BB", "*", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "BB"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingUnderThreatFromAnotherKing() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "BK", "*", "*"],
            ["*", "*", "*", "*", "WK", "*", "*", "*"],
            ["*", "*", "*", "BN", "BB", "*", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingUnderThreatFromQueen() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "WK", "*", "BQ", "*"],
            ["*", "*", "*", "BN", "BB", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertFalse(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
    
    func testKingNotUnderThreat() {
        let textGrid = [
            ["BK", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "BR", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "WK", "*", "*", "*"],
            ["*", "*", "*", "BN", "BB", "*", "BQ", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 4)
        XCTAssertTrue(KingThreatStatusCheck().isKingSafe(gameBoard, origin: origin, player: .white))
    }
}
