//
//  KingThreatStatusCheckTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class KingThreatStatusCheckTests: XCTestCase {
    
    func testKingDetectedAsUnderThreat() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BR", "*", "WK", "WP", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        XCTAssertTrue(KingThreatStatusCheck().isKingUnderAttack(gameBoard, origin: origin, player: .white))
    }
    
    func testKingNotDetectedAsUnderThreat() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BN", "*", "*", "*", "*"],
            ["*", "*", "BB", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "BP", "*", "WK", "BP", "*", "*", "*"],
            ["*", "*", "BR", "*", "*", "BQ", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        XCTAssertFalse(KingThreatStatusCheck().isKingUnderAttack(gameBoard, origin: origin, player: .white))
    }
    
    func testKingDetectedAsUnderThreatFromPawn() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "BP", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        XCTAssertTrue(KingThreatStatusCheck().isKingUnderAttack(gameBoard, origin: origin, player: .white))
    }
    
    func testKingNotDetectedAsUnderThreatFromPawn() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "BP", "*", "*", "*", "*"],
            ["*", "*", "*", "WK", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        XCTAssertFalse(KingThreatStatusCheck().isKingUnderAttack(gameBoard, origin: origin, player: .white))
    }
    
}
