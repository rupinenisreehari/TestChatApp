//
//  ChatHistoryViewModel.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 22/04/25.
//

import SwiftUI
import CoreData

class ChatHistoryViewModel: ObservableObject {
    @Published var messages: [Conversation] = []
    @State var chatManager: ChatManager
    
    init() {
        chatManager = ChatManager(username: UserDefaults.standard.string(forKey: "username") ?? "")
        print("ChatHistoryViewModel :: going to connect \(chatManager)")
        chatManager.connectSocket()
//        let request = {
//            let request = Messages.fetchRequest()
////            // Filter the request results, such as to only return unchecked items.
////            request.predicate = NSPredicate(format: "isChecked = false")
//            // Sort the fetched results, such as ascending by name.
//            request.sortDescriptors = [NSSortDescriptor(keyPath: \Messages.timestamp, ascending: true)]
//            request.resultType = .dictionaryResultType
//            request.propertiesToFetch = ["id", "message", "participant", "sent", "status", "timestamp"]
//            request.returnsDistinctResults = true
//            return request
//        }()
    }
    
    func fetchMessages() {
        chatManager.connectSocket()
//        firestoreService.listenForMessages(conversationID: conversationID) { [weak self] messages in
//                    self?.messages = messages
//                }
    }
}
