//
//  User.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    var isCurrentUser: Bool {
        // Swiftの場合、return文1行で完結する場合、「return」は省略可能
        self.id == "1"
    }
}
