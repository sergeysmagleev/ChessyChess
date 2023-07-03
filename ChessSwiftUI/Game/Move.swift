//
//  Move.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 06.05.23.
//

import Foundation

struct Move: Equatable, Hashable, CustomStringConvertible {
    var source: Coordinate
    var destination: Coordinate
    
    var description: String {
        "\(source)->\(destination)"
    }
    
    init(source: Coordinate, destination: Coordinate) {
        self.source = source
        self.destination = destination
    }
}
