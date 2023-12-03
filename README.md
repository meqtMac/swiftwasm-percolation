# SwiftWasm Example, Percolation Simulation

[Live Site](https://meqtmac.github.io/swiftwasm-percolation/)

![](Documentation/Percolation.png)

Some Swifty Style UI.
```swift
@main
struct MyApp: WebApp {
    static let canvas = Canvas()
    var simulator: Simulator = Simulator(board: BoardCanvas(canvas: canvas.object.object!, n: 128, length: document.body.clientHeight.number! * 0.8))
    
    var body: [HTML] {
        Div(with: "Hello, World!")
        Self.canvas
        Div {
            Button("Step") {
                simulator.step()
                print("Step")
            }
            Button("Start") {
                simulator.start()
            }
            Button("Pause") {
                simulator.stop()
            }
        }
    }
}
```

