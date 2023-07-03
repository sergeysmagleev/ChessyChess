//
//  GameBoardTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class GameBoardTests: XCTestCase {
    
    func testBoardPopulatedFromTextForm() {
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
        XCTAssertEqual(gameBoard[0, 0], .occupied(.init(player: .black, type: .rook, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 1], .occupied(.init(player: .black, type: .knight, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 2], .occupied(.init(player: .black, type: .bishop, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 3], .occupied(.init(player: .black, type: .queen, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 4], .occupied(.init(player: .black, type: .king, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 5], .occupied(.init(player: .black, type: .bishop, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 6], .occupied(.init(player: .black, type: .knight, hasMoved: false)))
        XCTAssertEqual(gameBoard[0, 7], .occupied(.init(player: .black, type: .rook, hasMoved: false)))
        for i in 0 ..< 8 {
            XCTAssertEqual(gameBoard[1, i], .occupied(.init(player: .black, type: .pawn, hasMoved: false)))
        }
        for i in 2 ..< 6 {
            for j in 0 ..< 8 {
                XCTAssertEqual(gameBoard[i, j], .empty)
            }
        }
        for i in 0 ..< 8 {
            XCTAssertEqual(gameBoard[6, i], .occupied(.init(player: .white, type: .pawn, hasMoved: false)))
        }
        XCTAssertEqual(gameBoard[7, 0], .occupied(.init(player: .white, type: .rook, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 1], .occupied(.init(player: .white, type: .knight, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 2], .occupied(.init(player: .white, type: .bishop, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 3], .occupied(.init(player: .white, type: .queen, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 4], .occupied(.init(player: .white, type: .king, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 5], .occupied(.init(player: .white, type: .bishop, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 6], .occupied(.init(player: .white, type: .knight, hasMoved: false)))
        XCTAssertEqual(gameBoard[7, 7], .occupied(.init(player: .white, type: .rook, hasMoved: false)))
    }
    
    func testTraceLaterally() {
        let textGrid = [
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "Wn", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "Bp", "*", "Wr", "Wp", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"],
            ["*", "*", "*", "*", "*", "*", "*", "*"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let origin = Coordinate(4, 3)
        XCTAssertEqual(gameBoard.trace(from: origin, by: (0, -1), currentPlayer: .white), [.init(4, 2), .init(4, 1)])
        XCTAssertEqual(gameBoard.trace(from: origin, by: (0, 1), currentPlayer: .white), [])
        XCTAssertEqual(gameBoard.trace(from: origin, by: (-1, 0), currentPlayer: .white), [.init(3, 3), .init(2, 3)])
        XCTAssertEqual(gameBoard.trace(from: origin, by: (1, 0), currentPlayer: .white), [.init(5, 3), .init(6, 3), .init(7, 3)])
    }
}
