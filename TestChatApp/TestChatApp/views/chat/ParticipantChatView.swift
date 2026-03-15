//
//  ParticipantChatView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import SwiftUI

struct ParticipantChatView: View {
    var message: Messages
    
    var body: some View {
        HStack(alignment: .top) {
            Text("P")
                .frame(width: 40, height: 40)
                .background(Color(red: 1/255, green: 6/255, blue: 92/255))
                .foregroundColor(.white)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(message.text!)
//                    .padding(.vertical)
                    .background(Color.gray.opacity(0.0))
                    .frame(maxWidth: 250, alignment: .leading)
                Text(AppHelper.timeFromDate(date: message.date!))
                    .font(.system(size: 12))
            }
            Spacer()
        }
        .padding(.leading)
        .id(message.id)
    }
}
