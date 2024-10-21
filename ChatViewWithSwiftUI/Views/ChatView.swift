//
//  ChatView.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/19.
//

import SwiftUI

struct ChatView: View {
    
    let chat: Chat
    
    @State private var textFieldText: String = ""
    
    // メッセージエリアがタップされたら、キーボードを閉じる
    @FocusState private var textFieldForcused: Bool
    
    // 画面を閉じるためのイベントハンドラーを設定(ListViewへ戻るため)
    @Environment(\.dismiss) private var dismiss
    
    // ListViewの「@ObservedObject var vm」と同じオブジェクトを参照するようにする
    @EnvironmentObject var vm: ChatViewModel
    // クラス内の値が変更されたら、画面
    // 詳細はChatViewMode.addMessage()
    // @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
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

//#Preview {
//    ChatView()
//}


extension ChatView {
    
    private var messageArea: some View {
        // 画面のスクロールを動的にコントロールする(ScrollViewReader)
        // →これで、画面を開いた瞬間に最下行へスクロールするようにする
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    /*
                     // ForEachで配列を回す場合、idの指定が必要
                     ForEach(vm.messages, id: \.id) {_ in
                    */
                    
                    // MessageにIdentifiableを継承させてもForEachできる
                    ForEach(chat.messages) { message in
                        // 別ファイルから呼び出し
                        MessageRow(message: message)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 72)
            }
            // ダークモードにも対応するよう、アセットカタログで事前に設定
            .background(Color("Background"))
            // メッセージエリアのタップを検知
            .onTapGesture {
                textFieldForcused = false
            }
            // チャット画面を開いた瞬間を検知
            .onAppear {
                scrollToLast(proxy: proxy)
            }
        }
        
        
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
            
                // textFieldForcusedの状態に応じて、入力エリアの状態を変化させる
                .focused($textFieldForcused)
            
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color("Background"))
    }
    
    private var navigationArea: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    // ⚠️foregroundStyle()では色が反映されなかった
                    .foregroundColor(.primary)
            }

            
            
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
        if !textFieldText.isEmpty {
            vm.addMessage(chatId: chat.id, text: textFieldText)
            textFieldText = ""
        }
    }
    
    private func scrollToLast(proxy: ScrollViewProxy) {
        if let lastMessage = chat.messages.last {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
        
    }
}
