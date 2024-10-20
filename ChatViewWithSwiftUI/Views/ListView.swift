//
//  ListView.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct ListView: View {
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
                ForEach(0..<5) { _ in
                    NavigationLink {
                        ChatView()
                        // 遷移先の画面上部に表示される戻るボタンを非表示にする
                            .toolbar(.hidden)
                    } label: {
                        listRow
                    }
                }
            }
        }
    }
    
    private var listRow: some View {
        HStack {
            Image("user01")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment:  .leading) {
                Text("タイトル")
                    .foregroundColor(.primary)
                Text("最新のメッセージ")
                    .font(.footnote)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text("12/31")
                .font(.caption)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
    }
}
