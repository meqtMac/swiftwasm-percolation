//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/27.
//
import JavaScriptKit

let document = JSObject.global.document
protocol WebApp {
    @HTMLBuilder var body: [HTML] { get }
    init()
}

extension WebApp {
    static  func setup() {
        _ = document.documentElement.style.setProperty("margin", "0")
        _ = document.documentElement.style.setProperty("width", "100vw")
        _ = document.documentElement.style.setProperty("height", "100vh")
        _ = document.documentElement.style.setProperty("position", "relative")
        _ = document.body.style.setProperty("color", "green")
        _ = document.body.style.setProperty("background-color", "black")
        _ = document.body.style.setProperty("width", "100%")
        _ = document.body.style.setProperty("height", "100%")
        _ = document.body.style.setProperty("padding", "0")
        _ = document.body.style.setProperty("margin", "0")
        _ = document.body.style.setProperty("text-align", "center")
    }

    static func main() {
        setup()
        let app: WebApp = Self.init()
        _ = app.body.map { element in
            _ = document.body.appendChild(element.object)
        }
    }
}
