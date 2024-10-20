//
//  ChatView.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/19.
//

import SwiftUI

struct ChatView: View {
    
    @State private var textFieldText: String = ""
    
    let vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // メッセージエリア
            messageArea
            // overlay()の引数の中で諸々設定している
                .overlay(
                    navigationArea
                    // 引数alignmentで表示位置指定 → 今回は画面上部
                    , alignment: .top
                )
            //　インプットエリア
            inputArea
        }
    }
}

#Preview {
    ChatView()
}


extension ChatView {
    
    
    
    private var messageArea: some View {
        ScrollView {
            VStack(spacing: 0) {
                /*
                 // ForEachで配列を回す場合、idの指定が必要
                 ForEach(vm.messages, id: \.id) {_ in
                */
                
                // MessageにIdentifiableを継承させてもForEachできる
                ForEach(vm.messages) { message in
                    // 別ファイルから呼び出し
                    MessageRow(message: message)
                }
            }
            .padding(.horizontal)
            .padding(.top, 72)
        }
        // ダークモードにも対応するよう、アセットカタログで事前に設定
        .background(Color("Background"))
    }
    
    private var inputArea: some View {
        HStack {
            HStack {
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            TextField("Aa", text: $textFieldText)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            // 入力エリアの角を丸くする
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "face.smiling")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                    ,alignment: .trailing
                )
                .onSubmit {
                    sendMessage()
                }
            
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color("Background"))
    }
    
    private var navigationArea: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .font(.title2)
            Text("Title")
                .font(.title2.bold())
            Spacer()
            HStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
        }
        .padding()
        .background(Color("Background").opacity(0.9))
    }
    
    private func sendMessage() {
        vm.addMessage(text: textFieldText)
    }
}
