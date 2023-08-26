import JavaScriptKit
import Foundation

struct Coordinate {
    let x: Int
    let y: Int
}

class BoardCanvas {
    let context: JSObject
    let n: Int
    let openColor =  "#FFFFFF"
    let fullColor = "#0000FF"
    var grid: Percolation
    let cellLength: Double
    let padding: Double
    
    init(canvas: JSObject, n: Int, length: Double) {
        self.n = n
        context = canvas.getContext!("2d").object!
        canvas.width = .number(length)
        canvas.height = .number(length)
        self.grid = Percolation(n: n)
        self.cellLength = length / Double(n) * 0.9
        self.padding = length / Double(n) * 0.1
        context.fillStyle = .string(openColor)
    }

    func getCellRect(at point: Coordinate) -> CGRect {
        CGRect(origin: CGPoint(x: Double(point.x) * (cellLength + padding), y: Double(point.y) * (cellLength + padding)),
                      size: CGSize(width: cellLength, height: cellLength))
    }
    
    func setOpen(at point: Coordinate) {
        context.fillStyle = .string(openColor)
        let rect = getCellRect(at: point)
        _ = context.fillRect!(Double(rect.origin.x), Double(rect.origin.y), Double(rect.size.width), Double(rect.size.height))
    }
    
    func setFull(at point: Coordinate) {
        context.fillStyle = .string(fullColor)
        let rect = getCellRect(at: point)
        _ = context.fillRect!(Double(rect.origin.x), Double(rect.origin.y), Double(rect.size.width), Double(rect.size.height))
    }

    func setClear(at point: Coordinate) {
        let rect = getCellRect(at: point)
        _ = context.clearRect!(Double(rect.origin.x), Double(rect.origin.y), Double(rect.size.width), Double(rect.size.height) )
    }
    
    func update() {
        for x in 0..<n {
            for y in 0..<n {
                if grid.isFull(row: y, column: x) {
                    setFull(at: Coordinate(x: x, y: y))
                }
            }
        }
    }
    
}
