//
//  Chat.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

struct Chat: Decodable {
    let id: String
    let messages: [Message]
}
