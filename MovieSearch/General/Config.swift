//
//  Config.swift
//  MovieSearch
//
//  Created by Anna Filin on 22/11/2024.
//

import Foundation

//struct Config {
//    static var apiKey: String {
//        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
//            fatalError("API Key not found!")
//        }
//        return key
//    }
//}
struct Config {
    static var apiKey: String {
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API Key not found!")
        }
        print("API Key from Config: \(key)") // Для проверки
        return key
    }
}
