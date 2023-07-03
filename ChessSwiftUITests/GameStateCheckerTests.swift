//
//  GameStateCheckerTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class GameStateCheckerTests: XCTestCase {
    
    func testNormalState() {
        let textGrid = [
            ["Br", "*",  "*",  "*",  "BR", "*",  "*",  "BK"],
            ["Bp", "*",  "*",  "*",  "*",  "Bp", "BB", "*" ],
            ["*",  "*",  "WN", "WB", "*",  "*",  "*",  "BP"],
            ["*",  "*",  "*",  "*",  "*",  "WN", "*",  "*" ],
            ["*",  "*",  "WP", "WP", "*",  "BP", "BN", "*" ],
            ["*",  "WQ", "*",  "*",  "BP", "*",  "*",  "*" ],
            ["Wp", "*",  "*",  "*",  "WP", "*",  "WB", "BQ"],
            ["Wr", "*",  "*",  "WR", "*",  "WK", "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let state = GameStateChecker().checkState(board: gameBoard, player: .white)
        XCTAssertEqual(state, .normal)
    }
    
    func testCheckState() {
        let textGrid = [
            ["Br", "Bn", "Bb", "*",  "Bk", "Bb", "Bn", "Br"],
            ["Bp", "Bp", "Bp", "Bp", "*",  "Bp", "Bp", "Bp"],
            ["*",  "*",  "*",  "*",  "BP", "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "BQ"],
            ["*",  "*",  "*",  "*",  "*",  "WP", "*",  "*" ],
            ["Wp", "Wp", "Wp", "Wp", "Wp", "*",  "Wp", "Wp"],
            ["Wr", "Wn", "Wb", "Wq", "Wk", "Wb", "Wn", "Wr"]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let state = GameStateChecker().checkState(board: gameBoard, player: .white)
        XCTAssertEqual(state, .check)
    }
    
    func testCheckmateState() {
        let textGrid = [
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["Bp", "*",  "*",  "*",  "WQ", "BN", "BK", "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "BR"],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "WP", "*",  "BN", "*",  "*",  "WK"],
            ["*",  "*",  "*",  "*",  "WP", "*",  "*",  "WP"],
            ["Wp", "*",  "*",  "*",  "*",  "BR", "Wp", "*" ],
            ["*",  "*",  "*",  "BB", "*",  "WB", "*",  "Wr"],
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let state = GameStateChecker().checkState(board: gameBoard, player: .white)
        XCTAssertEqual(state, .checkmate)
    }
    
    func testStalemateState() {
        let textGrid = [
            ["BK", "*",  "*",  "BR", "*",  "BR", "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "BQ", "*" ],
            ["*",  "*",  "*",  "*",  "WK", "*",  "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let state = GameStateChecker().checkState(board: gameBoard, player: .white)
        XCTAssertEqual(state, .stalemate)
    }
    
    func testUndefinedState() {
        let textGrid = [
            ["BK", "*",  "*",  "BR", "*",  "BR", "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "BQ", "*" ],
            ["*",  "*",  "*",  "*",  "*",  "*",  "*",  "*" ]
        ]
        guard let gameBoard = GameBoard.create(fromGrid: textGrid) else {
            XCTFail()
            return
        }
        let state = GameStateChecker().checkState(board: gameBoard, player: .white)
        XCTAssertEqual(state, .undefined)
    }
    
}
