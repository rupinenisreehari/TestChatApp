//
//  FirestoreService.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 22/04/25.
//

import FirebaseFirestore

protocol FirestoreServiceProtocol {
//    func sendMessage(_ message: Message, conversationID: String)
    func listenForMessages(conversationID: String, completion: @escaping ([Conversation]) -> Void)
}

class FirestoreService: FirestoreServiceProtocol {
    private let db = FirebaseFirestore.Firestore.firestore()

//    func sendMessage(_ message: Message, conversationID: String) {
//        try? db.collection("conversations").document(conversationID).collection("messages").addDocument(from: message)
//    }

    func listenForMessages(conversationID: String, completion: @escaping ([Conversation]) -> Void) {
        db.collection("conversations").document(conversationID).collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                let messages = documents.compactMap { try? $0.data(as: Conversation.self) }
                completion(messages)
            }
    }
}
