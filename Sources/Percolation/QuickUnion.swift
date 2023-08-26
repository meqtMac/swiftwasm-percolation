//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/26.
//

import Foundation
protocol Union {
    associatedtype Index
    func isConnected(left: Index, right: Index) -> Bool
    mutating func union(left: Index, right: Index)
}

/// Weighted quick-union with path compression: any sequence of M union-find ops on N objects makes `<= c (N + M lg^* N)` array accesses.
struct QuickUnion: Union {
    typealias Index = Int
    private var ids: [Int]
    /// self included for the child count
    private var childCount: [Int]
    
    let n: Int
    init(n: Int) {
        self.n = n
        ids = (0..<n).map { $0 }
        childCount = [Int](repeating: 1, count: n)
    }
    
    private mutating func root(of index: Int) -> Int {
        var i = index
        while (i != ids[i]) {
            ids[i] = ids[ids[i]]
            i = ids[i]
        }
        return i
    }
    
    private func plainRoot(of index: Int) -> Int {
        var i = index
        while (i != ids[i]) {
            i = ids[i]
        }
        return i

    }
    
    /// `lg(n)` in worst case
    func isConnected(left: Int, right: Int) -> Bool {
        plainRoot(of: left) == plainRoot(of: right)
    }
    
    /// `lg(n)`
    mutating func union(left: Int, right: Int) {
        let i = root(of: left)
        let j = root(of: right)
        if i == j {
            return
        } else if childCount[i] < childCount[j] {
            ids[i] = j
            childCount[j] += childCount[i]
        } else {
            ids[j] = i
            childCount[i] += childCount[j]
        }
    }
}

/// Weighted quick-union with path compression: any sequence of M union-find ops on N objects makes `<= c (N + M lg^* N)` array accesses.
struct QuickUnionUF: Union {
    typealias Index = Int
    private var ids: [Int]
    /// self included for the child count
    private var childCount: [Int]
    
    let n: Int
    init(n: Int) {
        self.n = n
        ids = (0..<n).map { $0 }
        childCount = [Int](repeating: 1, count: n)
    }
    
    private func root(of index: Int) -> Int {
        var i = index
        while (i != ids[i]) {
            i = ids[i]
        }
        return i
    }
    
    /// `lg(n)` in worst case
    func isConnected(left: Int, right: Int) -> Bool {
        root(of: left) == root(of: right)
    }
    
    /// `lg(n)`
    mutating func union(left: Int, right: Int) {
        let i = root(of: left)
        let j = root(of: right)
        ids[i] = j
   }
}
