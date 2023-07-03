//
//  StringHexTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 28.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class StringHexTests: XCTestCase {
    
    func testUppercaseHexIsParsedCorrectly() {
        XCTAssertEqual("A0BF".fromHex(), 41151)
    }
    
    func testLowercaseHexIsParsedCorrectly() {
        XCTAssertEqual("cf3d".fromHex(), 53053)
    }
    
    func testSingleDigitHexIsParsedCorrectly() {
        XCTAssertEqual("b".fromHex(), 11)
    }
    
    func testTwoDigitHexIsParsedCorrectly() {
        XCTAssertEqual("ac".fromHex(), 172)
    }
    
    func testSixDigitHexIsParsedCorrectly() {
        XCTAssertEqual("abcdef".fromHex(), 11259375)
    }
    
    func testZeroIsParsedCorrectly() {
        XCTAssertEqual("00".fromHex(), 0)
    }
    
    func testInvalidInputReturnsZero() {
        XCTAssertEqual("notAHexNumber".fromHex(), 0)
    }

}
