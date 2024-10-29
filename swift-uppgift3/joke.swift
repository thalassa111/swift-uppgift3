//
//  joke.swift
//  swift-uppgift3
//
//  Created by Dennis on 2024-10-29.
//

import Foundation

struct Joke: Codable {
    let error: Bool
    let category: String
    let type: String
    let setup: String
    let delivery: String
    let flags: Flags
    let id: Int
    let safe: Bool
    let lang: String
    
    struct Flags: Codable {
        let nsfw: Bool
        let religious: Bool
        let political: Bool
        let racist: Bool
        let sexist: Bool
        let explicit: Bool
    }
}
