//
//  ListView.swift
//  ChatViewWithSwiftUI
//
//  Created by Apple on 2024/10/20.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("トーク")
                    .font(.title2.bold())
                
                Spacer()
                
                HStack {
                    Circle()
                        .frame(width: 40, height: 40)
                    Circle()
                        .frame(width: 40, height: 40)
                    Circle()
                        .frame(width: 40, height: 40)
                }
            }
            // List
            ScrollView {
                VStack {
                    ForEach(0..<5) { _ in
                        HStack {
                            Circle()
                                .frame(width: 60, height: 60)
                            VStack(alignment:  .leading) {
                                Text("タイトル")
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
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ListView()
}
