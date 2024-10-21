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
    
    // 最新のメッセージ
    var recentMessageText: String {
        guard let recentMessage = self.messages.last else { return "" }
        
        return recentMessage.text
    }
    
    // 最新のメッセージの日時
    var recentMessageDataString: String {
        guard let recentMessage = self.messages.last else { return "" }
        
        let formatter = DateFormatter()
        // 最初はJSONの値を受け取るため、フォーマットの形式をJSONに合わせる
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: recentMessage.date) else { return "" }
        // 受けてからは、画面に見やすい表示にするためフォーマット形式をコンパクトにする
        formatter.dateFormat = "MM/dd"
        
        return formatter.string(from: date)
    }
}
