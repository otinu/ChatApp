//
//  ChatViewModel.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var chatData: [Chat] = []
    
    // イニシャライザ
    init() {
        chatData = fetchChatData()
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
    
    func addMessage(chatId: String, text: String) {
        
        // firstIndex →　条件がtrueになる最初の要素のインデックスを返却
        guard let index = chatData.firstIndex(where: { chat in
            chat.id == chatId
        } ) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateString = formatter.string(from: Date())
        
        let newMessage = Message(id: UUID().uuidString,
                                 text: text,
                                 user: User.currentUser,
                                 date: formattedDateString,
                                 alreadyRead: false)
        
        /*
         1. 単にappendしただけでは、画面ロードは終わってるため、画面反映はされない
         2. ChatViewの中で宣言された変数ChatViewModel に@ObservedObject を付与
         3. 変数ChatViewModelのクラスである、ChatViewModelにObservableObject を継承させる
         4. クラスChatViewModel内で変動する可能性のあるプロパティ(フィールド)に@Published を付与(今回はmessages)
         */
        chatData[index].messages.append(newMessage)
    }
    
    func getTitle(messages: [Message]) -> String {
        var title = ""
        var userIds: [String] = []
        
        for message in messages {
            let id = message.user.id
            
            if id == User.currentUser.id { continue }
            if userIds.contains(id) { continue }
            userIds.append(id)
            
            let name = message.user.name
            title += title.isEmpty ? "\(name)" : ", \(name)"
        }
        
        return title
    }
}
