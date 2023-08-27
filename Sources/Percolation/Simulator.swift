//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/27.
//

import JavaScriptKit

class Simulator {
    var board: BoardCanvas
    init(board: BoardCanvas) {
        self.board = board
        self.board.update()
    }
    
    func step() {
        for _ in 0..<5 {
            let row = Int.random(in: 0..<board.n)
            let column = Int.random(in: 0..<board.n)
            board.grid.open(row: row, column: column)
            board.setOpen(at: Coordinate(x: column, y: row))
        }
        board.update()
    }
    
    var timer: JSValue?
    func start() {
        guard self.timer == nil else { return }
        self.timer = JSObject.global.setInterval!(tickFn, 1)
    }
    
    lazy var tickFn = JSClosure { [weak self] _ in
        self?.step()
        return .undefined
    }
    
    func stop() {
        guard let timer = self.timer else { return }
        _ = JSObject.global.clearInterval!(timer)
        self.timer = nil
    }
}
