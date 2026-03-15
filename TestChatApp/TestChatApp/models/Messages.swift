//
//  Message.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import Foundation

extension Messages: Encodable {
    
    private enum CodingKeys: String, CodingKey { case id, from, text, participant, sent, date, status }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(from, forKey: .from)
        try container.encode(text, forKey: .text)
        try container.encode(participant, forKey: .participant)
        try container.encode(sent, forKey: .sent)
        try container.encode(date, forKey: .date)
        try container.encode(status, forKey: .status)
    }
    
    func jsonData() -> String {
        var json: String = "{}"
        do {
            let jsonData = try JSONEncoder().encode(self)
            json = String(data: jsonData, encoding: .utf8) ?? ""
        } catch (let error) {
            print("Messages :: json :: error :: \(error)")
        }
        return json
    }
}
