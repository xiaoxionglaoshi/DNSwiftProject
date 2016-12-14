//
//  DNCustomParser.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/5.
//  Copyright © 2016年 wjn. All rights reserved.
//

struct ParserError: Error {
    let message: String
}

struct Parser {
    let dictionary: [String: Any]?
    
    init(dictionary: [String: Any]?) {
        self.dictionary = dictionary
    }
    
    func fetch<T>(key: String) throws -> T {
        let fetchedOptional = dictionary?[key]
        guard let fetched = fetchedOptional else  {
            throw ParserError(message: "未发现的key: \(key)")
        }
        guard let typed = fetched as? T else {
            throw ParserError(message: "该key: \(key)不是正确类型. 正确类型为: \(fetched)")
        }
        return typed
    }
    
    func fetchOptional<T>(key: String) throws -> T? {
        let fetchedOptional = dictionary?[key]
        guard let fetched = fetchedOptional else {
            return nil
        }
        guard let typed = fetched as? T else {
            throw ParserError(message: "该key: \(key)不是正确类型. 正确类型为: \(fetched)")
        }
        return typed
    }
    
    func fetch<T, U>(key: String, transformation: (T) -> U?) throws -> U {
        let fetched: T = try fetch(key: key)
        guard let transformed = transformation(fetched) else {
            throw ParserError(message: "key: \(key) value: \(fetched) 无法转换")
        }
        return transformed
    }
    
    func fetchOptional<T, U>(key: String, transformation: (T) -> U?) -> U? {
        return (dictionary?[key] as? T).flatMap(transformation)
    }
    
    func fetchArray<T, U>(key: String, transformation: (T) -> U?) throws -> [U] {
        let fetched: [T] = try fetch(key: key)
        return fetched.flatMap(transformation)
    }
}
