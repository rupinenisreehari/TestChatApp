//
//  Conversation.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import Foundation

struct Conversation: Codable, Identifiable {
    let id: String
    let participant: String
    let lastMessage: String?
    let timestamp: Date?
}
