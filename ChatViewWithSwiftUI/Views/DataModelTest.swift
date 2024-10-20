//
//  DataModelTest.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct DataModelTest: View {
    
    let user1 = User(id: "1", name: "John", image: "user01")
    let user2 = User(id: "2", name: "Key", image: "user02")
    
    let message = Message(text: "Hello",
                          user: User(id: "1", name: "John", image: "user01"),
                          date: Date(),
                          alreadyRead: false)
    
    var body: some View {
        VStack {
            Text(message.text)
            Text(message.user.name)
            
            Text(user1.name)
            // Image(user1.image)
            
            Text(user2.name)
            // Image(user2.image)
            
            
            
        }
    }
}

#Preview {
    DataModelTest()
}
