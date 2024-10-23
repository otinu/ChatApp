//
//  ListView.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                header
                // List
                list
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ListView()
}

extension ListView {
    
    private var header: some View {
        HStack {
            Text("トーク")
                .font(.title2.bold())
            
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "text.badge.checkmark")
                Image(systemName: "square")
                Image(systemName: "ellipsis.bubble")
            }
            .font(.title2)
        }
    }
    
    private var list: some View {
        ScrollView {
            VStack {
                ForEach(vm.chatData) { chat in
                    NavigationLink {
                        ChatView(chat: chat)
                        // ChatViewでもvmを参照できるように渡す
                            .environmentObject(vm)
                        // 遷移先の画面上部に表示される戻るボタンを非表示にする
                            .toolbar(.hidden)
                    } label: {
                        listRow(chat: chat)
                    }
                }
            }
        }
    }
    
    // これで、Viewが引数をもてるようになる。varがfuncになってる点がミソ
    private func listRow(chat: Chat) -> some View {
    // private var listRow: some View {
        HStack {
            Image("user01")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment:  .leading) {
                Text(vm.getTitle(messages: chat.messages))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                Text(chat.recentMessageText)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text(chat.recentMessageDataString)
                .font(.caption)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
    }
}
