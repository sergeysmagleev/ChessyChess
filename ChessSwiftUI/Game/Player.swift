//
//  Player.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import Foundation

enum Player: Equatable, CustomStringConvertible {
    case black, white
    
    var description: String {
        switch self {
        case .white:
            return "White"
        case .black:
            return "Black"
        }
    }
    
    var opponent: Self {
        switch self {
        case .black:
            return .white
        case .white:
            return .black
        }
    }
    
    var forward: Int {
        self == .black ? 1 : -1
    }
    
    mutating func toggle() {
        self = opponent
    }
}
