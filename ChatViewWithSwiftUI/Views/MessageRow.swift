//
//  MessageRow.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct MessageRow: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 48, height: 48)
            Text("Hello World")
                .padding()
                .background(.white)
                .cornerRadius(30)
            VStack(alignment: .trailing) {
                // 既読を右下に表示させるためにSpacer()を設置。
                // プレビューでは画面全体の右下でも、シミュレータを起動するとキレイに配置される
                Spacer()
                Text("既読")
                // 現在時刻の表示
                Text(formattedDataString)
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            Spacer()
        }
        .padding(.bottom)
    }
    
    private var formattedDataString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}

#Preview {
    MessageRow()
        .background(.cyan)
}
