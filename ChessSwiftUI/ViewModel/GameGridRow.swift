//
//  GameGridRow.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 04.05.23.
//

import Foundation

struct GameGridRow: Identifiable {
    
    private(set) var id = UUID().uuidString
    
    var rowNumber: Int
    var viewModels: [ViewModel]
    
    init(rowNumber: Int, viewModels: [ViewModel]) {
        self.rowNumber = rowNumber
        self.viewModels = viewModels
    }
     
}
