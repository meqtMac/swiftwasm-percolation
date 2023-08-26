import JavaScriptKit

class App {
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

let document = JSObject.global.document
let canvas = document.getElementById("app-canvas").object!
var iterateButton = document.getElementById("app-step-button")
var startButton = document.getElementById("app-start-button")
var stopButton = document.getElementById("app-stop-button")
var resetButton = document.getElementById("app-reset-button")
var controlsContainer = document.getElementById("app-controls-container")
let n = 200
let length = document.body.clientHeight.number! - controlsContainer.clientHeight.number!

var boardView = BoardCanvas(canvas: canvas, n: n, length: length)
var lifeGame = App(board: boardView)
let nextFn = JSClosure { _ in
    lifeGame.step()
    return nil
}

let startFn = JSClosure { _ in
    lifeGame.start()
    return nil
}

let stopFn = JSClosure { _ in
    lifeGame.stop()
    return nil
}

let resetFn = JSClosure { _ in
    lifeGame = App(board: boardView)
    return nil
}
iterateButton.onclick = .object(nextFn)
startButton.onclick = .object(startFn)
stopButton.onclick = .object(stopFn)
resetButton.onclick = .object(resetFn)
