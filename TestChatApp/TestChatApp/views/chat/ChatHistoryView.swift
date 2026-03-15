//
//  ChatHistory.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

struct ChatHistoryView: View {
    @ObservedObject var viewModel = ChatHistoryViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ChatHistory.date, ascending: false)],
        animation: .default) var messages: FetchedResults<ChatHistory>
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messages) { message in
                        NavigationLink(value: message) {
                            ChatHistoryItemView(message: message)
                        }
                    }
                }
                .clipped() 
                .scrollIndicators(.never)
            }
            HStack {
                Button(action: {
                    Router.shared.path.append(1)
                }) {
                    Text("Start New Chat")
                        .padding(10)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
            }
            .padding(10)
            .background(.white)
            .cornerRadius(50)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarBackButtonHidden()
        .navigationTitle("Conversations")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red:240/255, green:241/255, blue: 249/255))
        .navigationDestination(for: ChatHistory.self) { item in
            let part = item.participant!
            ChatDetailedView(participant: part, chatManager: viewModel.chatManager)
        }
        .navigationDestination(for: Int.self) { item in
            StartNewChat(chatManager: viewModel.chatManager)
        }
    }
}

#Preview {
    ChatHistoryView()
}
