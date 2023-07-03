//
//  GameState.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import Foundation

enum GameState: Equatable {
    case undefined
    case normal
    case check
    case checkmate
    case stalemate
}
