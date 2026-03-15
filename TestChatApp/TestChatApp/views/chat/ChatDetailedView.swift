//
//  ChatDetailedView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import SwiftUI

struct ChatDetailedView: View {
    @ObservedObject var detailedViewModel: ChatDetailedViewModel
    @State var inputText: String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    var messageRequest : FetchRequest<Messages>
    var messages : FetchedResults<Messages>{messageRequest.wrappedValue}
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Messages.date, ascending: true)],
////        predicate: NSPredicate(format: "participant = %@", participant)
//        animation: .default) var messages: FetchedResults<Messages>
    
    init(participant: String, chatManager: ChatManager) {
        detailedViewModel = ChatDetailedViewModel(participant: participant, chatManager: chatManager)
        self.messageRequest = FetchRequest(entity: Messages.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Messages.date, ascending: true)], predicate: NSPredicate(format: "participant = %@", participant))
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messages) { message in
                        if message.sent {
                            MyChatView(message: message)
                        } else {
                            ParticipantChatView(message: message)
                        }
                    }
                    if detailedViewModel.isTyping {
                        HStack (alignment: .top) {
                            Text("P")
                                .frame(width: 40, height: 40)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            Text("\(detailedViewModel.participant) is typing...")
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .clipped()
                .scrollIndicators(.never)
                .onChange(of: messages.count) { _ in
                    if let lastMessage = messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
                .onChange(of: inputText) { oldValue, newValue in
                    detailedViewModel.updateTypingStatus(isTyping: !inputText.isEmpty)
                }
            }
            HStack {
                Image(systemName: "microphone")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                
                TextField("Message...", text: $inputText)
                    .padding(.vertical)
                
                Button(action: {
                    if inputText.isEmpty {
                        
                    } else {
                        detailedViewModel.sendMessage(managedObjectContext: managedObjectContext, text: inputText)
                        inputText = ""
    //                    presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .background(inputText.isEmpty ? .gray : Color(red: 10/255, green: 22/255, blue: 228/255))
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
        .padding(.vertical)
        .navigationTitle(detailedViewModel.participant)
        .navigationBarTitleDisplayMode(.inline)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 70)
        .background(Color(red:240/255, green:241/255, blue: 249/255))
    }
}

#Preview {
    ChatDetailedView(participant: "", chatManager: ChatManager(username: "test@gmail.com"))
}
