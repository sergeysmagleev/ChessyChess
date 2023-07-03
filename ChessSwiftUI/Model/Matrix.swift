//
//  Matrix.swift
//  TicTacTocSwiftUI
//
//  Created by Sergey Smagleev on 28.04.23.
//

import Foundation

class Matrix<T>: Sequence {
    
    let rowsNum: Int
    let colsNum: Int
    private var storage: [T]
    
    func makeIterator() -> some IteratorProtocol {
        MatrixIterator(matrix: self)
    }
    
    init(rowsNum: Int, colsNum: Int, initialValue: T) {
        self.rowsNum = rowsNum
        self.colsNum = colsNum
        storage = .init(repeating: initialValue, count: rowsNum * colsNum)
    }
    
    init(rowsNum: Int, colsNum: Int, values: [T]) {
        self.rowsNum = rowsNum
        self.colsNum = colsNum
        storage = values
    }
    
    func deepCopy() -> Matrix<T> {
        .init(rowsNum: rowsNum, colsNum: colsNum, values: storage)
    }
    
    var rows: [[T]] {
        (0 ..< rowsNum).map { row in
            Array(storage[row * colsNum ..< colsNum * (row + 1)])
        }
    }
    
    func enumerated() -> [(Coordinate, T)] {
        let coordinates = (0 ..< rowsNum).flatMap { row in (0 ..< colsNum).map { col in Coordinate(row, col) } }
        return zip(coordinates, storage).toTupleSequence()
    }
    
    subscript(row: Int, col: Int) -> T {
        get {
            storage[row * colsNum + col]
        }
        set(value) {
            storage[row * colsNum + col] = value
        }
    }
    
    subscript(coordinate: Coordinate) -> T {
        get {
            self[coordinate.row, coordinate.col]
        }
        set(value) {
            self[coordinate.row, coordinate.col] = value
        }
    }
}

class MatrixIterator<T>: IteratorProtocol {
    
    var matrix: Matrix<T>
    var currentRow = 0
    var currentCol = 0
    
    init(matrix: Matrix<T>) {
        self.matrix = matrix
    }
    
    func next() -> T? {
        if currentCol == matrix.colsNum {
            currentCol = 0
            currentRow += 1
        }
        guard currentRow < matrix.rowsNum else {
            return nil
        }
        defer {
            currentCol += 1
        }
        return matrix[currentRow, currentCol]
    }
    
}
