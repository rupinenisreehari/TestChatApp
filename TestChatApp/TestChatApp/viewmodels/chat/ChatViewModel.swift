//
//  ChatViewModel.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 22/04/25.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Conversation] = []
    @Published var messageText: String = ""
    let conversationID: String
    let currentUserID: String
    private let firestoreService: FirestoreService

    init(conversationID: String, currentUserID: String, firestoreService: FirestoreService) {
        self.conversationID = conversationID
        self.currentUserID = currentUserID
        self.firestoreService = firestoreService
    }

    func fetchMessages() {
        firestoreService.listenForMessages(conversationID: conversationID) { [weak self] messages in
            self?.messages = messages
        }
    }

    func sendMessage() {
//        let message = Message(id: UUID().uuidString, senderID: currentUserID, text: messageText, timestamp: Date(), status: "sent")
//        firestoreService.sendMessage(message, conversationID: conversationID)
//        messageText = ""
    }
}
