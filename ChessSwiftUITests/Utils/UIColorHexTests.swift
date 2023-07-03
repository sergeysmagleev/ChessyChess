//
//  UIColorHexTests.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 28.05.23.
//

import Foundation
import XCTest
@testable import ChessSwiftUI

class ColorHexTests: XCTestCase {
    
    func testRedParsing() {
        XCTAssertEqual(UIColor.fromHex("0xFF0000"), .red)
    }
    
    func testGreenParsing() {
        XCTAssertEqual(UIColor.fromHex("0x00FF00"), .green)
    }
    
    func testBlueParsing() {
        XCTAssertEqual(UIColor.fromHex("0x0000FF"), .blue)
    }
    
    func testParsingWithoutPrefix() {
        XCTAssertEqual(UIColor.fromHex("FFFFFF"), .init(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
}
