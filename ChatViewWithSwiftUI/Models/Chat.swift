//
//  Chat.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

struct Chat: Decodable, Identifiable {
    let id: String
    let messages: [Message]
    
    var recentMessageText: String {
        guard let recentMessage = self.messages.last else { return "" }
        
        return recentMessage.text
    }
}
