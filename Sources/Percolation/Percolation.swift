//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/26.
//

import Foundation


protocol PercolationProtocol {
    /// creates n-by-n grid, with all sites initially blocked
    init(n: Int)
    /// opens the site (row, col) if it is not open already
    mutating func open(row: Int, column: Int)
    /// is the site (row, col) open?
    func isOpen(row: Int, column: Int) -> Bool
    /// is the site (row, col) full?
    func isFull(row: Int, column: Int) -> Bool
    /// returns the number of open sites
    func numberOfOpenSites() -> Int
    /// does the system percolate?
    func percolates() -> Bool
}

struct Percolation: PercolationProtocol {
    let n: Int
    private let upUnionIndex: Int
    private let downUnionIndex: Int
    private var quickUnionGrid: QuickUnion
    /// grid mark if the is open, open when true
    private var grid: [Bool]
    
    init(n: Int) {
        precondition(n > 0, "n must > 0")
        self.n = n
        upUnionIndex = n*n
        downUnionIndex = n*n+1
        /// `n*n` and `n*n+1` marks up and down
        quickUnionGrid = QuickUnion(n: n*n + 2)
        grid = [Bool](repeating: false, count: n*n)
    }
    
    private func isVaild(row: Int, column: Int) {
        assert(0 <= row && row < n && 0 <= column && column < n, "Invaild Argument")
    }
    
    private func unionIndex(row: Int, column: Int) -> Int {
        assert(0 <= column && column < n && -1 <= row && row <= n, "Invaild Argument")
        if row == -1 {
            return upUnionIndex
        } else if row == n {
            return downUnionIndex
        }else {
            return row * n + column
        }
    }
    
    mutating func open(row: Int, column: Int) {
        isVaild(row: row, column: column)
        if !isOpen(row: row, column: column) {
            grid[row * n + column] = true
        }
        let myUnionIndex = unionIndex(row: row, column: column)
        func unionIfOpen(adjscentRow: Int, adjscentColumn: Int) {
            if (0 <= adjscentColumn && adjscentColumn < n ) {
                let nextUnionIndex = unionIndex(row: adjscentRow, column: adjscentColumn)
                if nextUnionIndex == upUnionIndex || nextUnionIndex == downUnionIndex || isOpen(row: adjscentRow, column: adjscentColumn) {
                    quickUnionGrid.union(left: myUnionIndex, right: unionIndex(row: adjscentRow, column: adjscentColumn))
                }
            }
        }
        unionIfOpen(adjscentRow: row - 1, adjscentColumn: column)
        unionIfOpen(adjscentRow: row + 1, adjscentColumn: column)
        unionIfOpen(adjscentRow: row, adjscentColumn: column - 1)
        unionIfOpen(adjscentRow: row, adjscentColumn: column + 1)
    }
    
    func isOpen(row: Int, column: Int) -> Bool {
        isVaild(row: row, column: column)
        return grid[row * n + column]
    }
    
    func isFull(row: Int, column: Int) -> Bool {
        isVaild(row: row, column: column)
        let unionIndex = unionIndex(row: row, column: column)
        return quickUnionGrid.isConnected(left: unionIndex, right: upUnionIndex)
    }
    
    func numberOfOpenSites() -> Int {
        grid.filter { $0 }.count
    }
    
    func percolates() -> Bool {
        quickUnionGrid.isConnected(left: upUnionIndex, right: downUnionIndex)
    }
}

