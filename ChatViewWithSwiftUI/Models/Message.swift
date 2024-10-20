//
//  Message.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

struct Message: Decodable, Identifiable {
    // IDを自動採番
    // let id: String = UUID().uuidString
    
    let id: String
    let text: String
    let user: User
    let date: String
    let alreadyRead: Bool
}
