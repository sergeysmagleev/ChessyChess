//
//  Row.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import Foundation

infix operator +
infix operator -
infix operator *
    
struct Coordinate: Equatable, Hashable, CustomStringConvertible {

    var row: Int
    var col: Int
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
    
    init(_ tuple: (Int, Int)) {
        self.row = tuple.0
        self.col = tuple.1
    }
    
    var description: String {
        "[\(row)-\(col)]"
    }
    
    func moveBy(_ delta: Coordinate) -> Coordinate {
        .init(row + delta.row, col + delta.col)
    }
    
    func moveBy(_ delta: (Int, Int)) -> Coordinate {
        .init(row + delta.0, col + delta.1)
    }
    
    static func +(_ lhs: Coordinate, _ rhs: Coordinate) -> Coordinate {
        .init(lhs.row + rhs.row, lhs.col + rhs.col)
    }
    
    static func +(_ lhs: Coordinate, _ rhs: (Int, Int)) -> Coordinate {
        .init(lhs.row + rhs.0, lhs.col + rhs.1)
    }
    
    static func -(_ lhs: Coordinate, _ rhs: Coordinate) -> Coordinate {
        .init(lhs.row - rhs.row, lhs.col - rhs.col)
    }
    
    static func -(_ lhs: Coordinate, _ rhs: (Int, Int)) -> Coordinate {
        .init(lhs.row - rhs.0, lhs.col - rhs.1)
    }
    
    static func *(_ lhs: Coordinate, _ multiplier: Int) -> Coordinate {
        .init(lhs.row * multiplier, lhs.col * multiplier)
    }
}
