//
//  MyChatView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import SwiftUI

struct MyChatView: View {
    var message: Messages
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .trailing) {
                Text(message.text!)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .frame(maxWidth: 250, alignment: .trailing)
                Text(AppHelper.timeFromDate(date: message.date!))
                    .font(.system(size: 12))
            }
        }
        .padding(.top)
        .padding(.trailing)
        .id(message.id)
    }
}
