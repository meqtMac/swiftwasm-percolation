//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/8/27.
//

import JavaScriptKit

protocol HTML {
    var object: JSValue { get set }
    mutating func append(child htmlElement: HTML)
    mutating func setStyle(key: String, value: String)
    init()
    init(@HTMLBuilder content elements: () -> [HTML], sytles: [String: String])
}

@resultBuilder
enum HTMLBuilder {
    public typealias Component = [HTML]
    
    static func buildBlock(_ components: HTML...) -> [HTML] {
        return components
    }
    
    public static func buildBlock(_ components: Component...) -> Component {
        return components.flatMap { $0 }
    }
    public static func buildExpression(_ expression: HTML) -> Self.Component {
        return [expression]
    }
    
    public static func buildEither(first component: Component) -> Self.Component {
        return component
    }
    
    public static func buildEither(second component: Component) -> Self.Component {
        return component
    }
    
    public static func buildArray(_ components: [Self.Component]) -> Self.Component {
        return components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: Self.Component?) -> Self.Component {
        if let component {
            return component
        } else {
            return []
        }
    }

}

extension HTML {
    func append(child htmlElement: HTML) {
        _ = object.appendChild(htmlElement.object);
    }
    
    func setStyle(key: String, value: String) {
        _ = object.style.setProperty(key, value)
    }
    
    init(@HTMLBuilder content elements: () -> [HTML] = { [] }, sytles: [String : String] = [:] ) {
        self.init()
        for element in elements() {
            append(child: element)
        }
        for (key, value) in sytles {
            setStyle(key: key, value: value)
        }
    }
}

struct Div: HTML {
    var object: JSValue
    
    init() {
        self.object = document.createElement("div")
    }
    
    init(with innerText: String, @HTMLBuilder content elements: () -> [HTML] = { [] }, styles: [String: String] = [:]) {
        self.init(content: elements, sytles: styles)
        object.innerText = .init(stringLiteral: innerText)
    }
}

struct Button: HTML {
    var object: JSValue
    
    init() {
        self.object = document.createElement("button")
    }
    
    init(_ title: String, styles: [String: String] = [:]) {
        self.init(sytles: styles)
        object.textContent = .init(stringLiteral: title)
    }
    
    init(_ title: String, styles: [String: String] = [:], onClick block: @escaping () -> Void = {}) {
        self.init(sytles: styles)
        object.textContent = .init(stringLiteral: title)
        let callBackClosure = JSClosure { _ in
            block()
            return nil
        }
        object.onclick = .object(callBackClosure)
    }
}

struct Canvas: HTML {
    var object: JSValue
    
    init() {
        self.object = document.createElement("canvas")
    }
}
