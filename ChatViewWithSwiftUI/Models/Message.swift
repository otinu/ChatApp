//
//  Message.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

struct Message {
    // IDを自動採番
    // let id: String = UUID().uuidString
    let text: String
    let user: User
    let date: String
    let alreadyRead: Bool
}
