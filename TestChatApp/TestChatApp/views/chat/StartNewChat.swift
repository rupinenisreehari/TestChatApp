//
//  StartNewChat.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 24/04/25.
//

import SwiftUI

struct StartNewChat: View {
    @State var participant: String = ""
    @State var chatManager: ChatManager
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(chatManager: ChatManager) {
        self.chatManager = chatManager
    }
    
    var body: some View {
        VStack {
            TextField("asdf @gmail.com", text: $participant)
                .foregroundColor(.black)
                .padding()
                .frame(height: 50)
                .background(.white)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()
            Button {
                if participant.isEmpty {
                    
                } else {
                    Router.shared.path.append(Date())
                    print("path count :: " , Router.shared.path.count)
                }
            } label: {
                Text("Start")
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red:240/255, green:241/255, blue: 249/255))
        .navigationDestination(for: Date.self) { item in
            ChatDetailedView(participant: participant, chatManager: chatManager)
        }
    }
}

#Preview {
    StartNewChat(chatManager: ChatManager(username: "test@gmail.com"))
}
