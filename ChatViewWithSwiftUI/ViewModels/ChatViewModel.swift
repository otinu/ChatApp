//
//  ChatViewModel.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    var chatData: [Chat] = []
    @Published var messages: [Message] = []
    
    // イニシャライザ
    init() {
        chatData = fetchChatData()
        
        // chatData[0]の中にJSONの全データが入ってる
        messages = chatData[0].messages
    }
    
    private func fetchChatData() -> [Chat] {
        let fileName = "chatData.json"
        let data: Data
        
        // nilを返す可能性があるため、guard let
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            fatalError("ファイルパス取得に失敗しました")
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("ファイルのロードに失敗しました")
        }
        
        do {
            /*
             1.デコードの記述をするとコンパイルエラー発生
             2.構造体ChatでDecodableを継承(?)する必要あり
             3.構造体MessageでDecodableを継承(?)する必要あり
             4.構造体UserでDecodableを継承(?)する必要あり
             5.コンパイルエラー解消
             */
            return try JSONDecoder().decode([Chat].self, from: data)
        } catch let error {
            print(error)
            fatalError("JSONのデコードに失敗しました")
        }
        
        
    }
    
    func addMessage(text: String) {
        let newMessage = Message(id: UUID().uuidString,
                                 text: text,
                                 user: User.currentUser,
                                 date: Date().description,
                                 alreadyRead: false)
        
        /*
         1. 単にappendしただけでは、画面ロードは終わってるため、画面反映はされない
         2. ChatViewの中で宣言された変数ChatViewModel に@ObservedObject を付与
         3. 変数ChatViewModelのクラスである、ChatViewModelにObservableObject を継承させる
         4. クラスChatViewModel内で変動する可能性のあるプロパティ(フィールド)に@Published を付与(今回はmessages)
         */
        messages.append(newMessage)
    }
}
