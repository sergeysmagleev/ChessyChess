//
//  DebugUtil.swift
//  ChessSwiftUITests
//
//  Created by Sergey Smagleev on 21.05.23.
//

import Foundation

func setDiffPrintout<T: CustomStringConvertible>(_ lhs: Set<T>, _ rhs: Set<T>) -> String {
    "First set contains: \(Set(lhs).subtracting(Set(rhs)))\nSecond set contains: \(Set(rhs).subtracting(Set(lhs)))"
}
