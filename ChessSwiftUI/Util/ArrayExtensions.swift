//
//  ArrayExtensions.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 07.05.23.
//

import Foundation

extension Zip2Sequence {
    
    func toTupleSequence() -> [(Sequence1.Element, Sequence2.Element)] {
        map { ($0, $1) }
    }
}

extension Array {
    
    var isNotEmpty: Bool {
        !isEmpty
    }
}
