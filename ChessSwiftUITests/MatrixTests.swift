//
//  MatrixTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class MatrixTests: XCTestCase {
    
    func testEnumeration() {
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
        XCTAssertEqual(gameBoard.storage.enumerated().count, 64)
        XCTAssertEqual(gameBoard.storage.enumerated().filter { coordinate, item in
            item.currentCase == .occupied
        }.count, 32)
        XCTAssertEqual(gameBoard.storage.enumerated().filter { coordinate, item in
            guard case let .occupied(chessPiece) = item, chessPiece.player == .white else {
                return false
            }
            return true
        }.count, 16)
    }
    
}
