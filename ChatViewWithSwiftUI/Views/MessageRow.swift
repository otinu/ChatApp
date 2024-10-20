//
//  MessageRow.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top) {
            if message.user.isCurrentUser {
                Spacer()
                messageState
                messageText
            } else {
                userThumb
                messageText
                messageState
                Spacer()
            }
        }
        .padding(.bottom)
    }
}

//#Preview {
//    MessageRow()
//        .background(.cyan)
//}

extension MessageRow {
    private var userThumb: some View {
        
        Image(message.user.image)
            .resizable()
            .frame(width: 48, height: 48)
            .clipShape(Circle())
    }
    
    private var messageText: some View {
        Text(message.text)
            .padding()
            .background(.white)
            .cornerRadius(30)
    }
    
    private var messageState: some View {
        VStack(alignment: .trailing) {
            // 既読を右下に表示させるためにSpacer()を設置。
            // プレビューでは画面全体の右下でも、シミュレータを起動するとキレイに配置される
            Spacer()
            if message.user.isCurrentUser && message.alreadyRead {
                Text("既読")
            }
            // 現在時刻の表示
            Text(formattedDataString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    
    private var formattedDataString: String {
        let formatter = DateFormatter()
        // 最初はJSONの値を受け取るため、フォーマットの形式をJSONに合わせる
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: message.date) else { return "" }
        // 受けてからは、画面に見やすい表示にするためフォーマット形式をコンパクトにする
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
