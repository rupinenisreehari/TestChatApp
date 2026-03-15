//
//  ChatHistoryItemView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import SwiftUI

struct ChatHistoryItemView: View {
    @State var message: ChatHistory
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(message.participant ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
                Text(message.text ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .regular))
            }
            Spacer()
            Text(AppHelper.timeFromDate(date: message.date ?? Date()))
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(10)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

//#Preview {
//    ChatHistoryItemView()
//}
