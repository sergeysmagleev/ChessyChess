//
//  ViewModel.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 28.04.23.
//

import Foundation
import UIKit

struct ViewModel: Identifiable {
    
    private(set) var id = UUID().uuidString
    private(set) var value: String
    private(set) var pieceColor: UIColor
    private(set) var backgroundColor: UIColor
    private(set) var borderColor: UIColor
    private(set) var icon: UIImage?
    private(set) var onTap: () -> Void
    
    init(value: String,
         pieceColor: UIColor,
         backgroundColor: UIColor,
         borderColor: UIColor,
         icon: UIImage?,
         onTap: @escaping () -> Void) {
        self.value = value
        self.pieceColor = pieceColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.icon = icon
        self.onTap = onTap
    }
}
