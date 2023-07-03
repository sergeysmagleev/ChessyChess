//
//  UIColor+Hex.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 27.05.23.
//

import UIKit

extension UIColor {
    
    static func fromHex(_ hex: String) -> UIColor {
        var trimmedHex = hex
        trimmedHex.trimPrefix("0x")
        trimmedHex.trimPrefix("#")
        guard trimmedHex.count == 6 else {
            return .clear
        }
        let charArray = Array(trimmedHex)
        let r = CGFloat(String(charArray[0 ..< 2]).fromHex()) / 255.0
        let g = CGFloat(String(charArray[2 ..< 4]).fromHex()) / 255.0
        let b = CGFloat(String(charArray[4 ..< 6]).fromHex()) / 255.0
        return .init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}

extension String {
    
    static let hexMap: [String: Int] = [
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "A": 10,
        "B": 11,
        "C": 12,
        "D": 13,
        "E": 14,
        "F": 15
    ]
    
    func fromHex() -> Int {
        var mltp = 1
        var total = 0
        for char in reversed() {
            guard let value = Self.hexMap[char.uppercased()] else {
                return 0
            }
            total += value * mltp
            mltp *= 16
        }
        return total
    }
}
