//
//  ChatDetailedViewModel.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import Foundation
import SwiftUI
import CoreData

class ChatDetailedViewModel: ObservableObject {
    @State var chatManager: ChatManager
    @State var participant: String = ""
    @Published var isTyping: Bool = false
    
    init(participant: String, chatManager: ChatManager) {
        self.participant = participant
        self.chatManager = chatManager
    }
    
    func updateTypingStatus(isTyping: Bool) {
        print("ChatDetailedViewModel :: sendMessage :: isTyping :: \(isTyping)")
        chatManager.setDetailedViewModel(self)
        let from = UserDefaults.standard.string(forKey: "username")
        let key = KeyStatus(participant: participant, from: from, status: isTyping)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(key)
        let json = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
        chatManager.sendTypingStatus(message: json)
    }
    
    func sendMessage(managedObjectContext: NSManagedObjectContext, text: String) {
        print("ChatDetailedViewModel :: sendMessage")
        chatManager.setContext(context: managedObjectContext)
        
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let message = Messages(context: managedObjectContext)
        message.id = UUID()
        message.from = UserDefaults.standard.string(forKey: "username")
        message.text = text
        message.participant = participant
        message.sent = true
        message.date = Date()
        message.status = "sent"
        do {
            try managedObjectContext.save()
            //
            var chat: ChatHistory!
            let fetchMessage: NSFetchRequest<ChatHistory> = ChatHistory.fetchRequest()
            fetchMessage.predicate = NSPredicate(format: "participant = %@", participant)
            let results = try? managedObjectContext.fetch(fetchMessage)
            if results?.count == 0 {
                // here you are inserting
                chat = ChatHistory(context: managedObjectContext)
            } else {
                // here you are updating
                chat = results?.first
            }
            chat.id = message.id
            chat.from = message.from
            chat.text = message.text
            chat.participant = message.participant
            chat.sent = message.sent
            chat.date = message.date
            chat.status = message.status
            try managedObjectContext.save()
        } catch (let error) {
            print("Send Message :: error :: \(error)")
        }
        let json = message.jsonData()
        print("message :: json :: \(json)")
        chatManager.sendMessage(message: json)
    }
}
