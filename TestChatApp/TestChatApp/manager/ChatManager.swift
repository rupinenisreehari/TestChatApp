//
//  ChatManager.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import Foundation
import CoreData

public class ChatManager {
    private var socketService: SocketService = SocketService()
    private let username: String
    private var managedObjectContext: NSManagedObjectContext?
    private var chatDetailedViewModel: ChatDetailedViewModel?
    
    init(username: String) {
        self.username = username
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification(notification:)), name: Notification.Name("ChatMessageReceived"), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(receivedKeyNotification(notification:)), name: Notification.Name("KeyboardStatusReceived"), object: nil);
    }
    
    func setContext(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func setDetailedViewModel(_ chatDetailedViewModel: ChatDetailedViewModel) {
        self.chatDetailedViewModel = chatDetailedViewModel
    }
    
    func connectSocket() {
        print("ChatManager :: connectSocket")
        if !socketService.isConnected() {
            socketService.connectToServer(username: username)
        }
    }
    
    func sendMessage(message: String) -> Bool {
        print("ChatManager :: sendMessage")
        return socketService.sendMessage(message: message)
    }
    
    func sendTypingStatus(message: String) {
        print("ChatManager :: sendMessage")
        socketService.sendTypingStatus(message: message)
    }
    
    @objc func receivedNotification(notification: Notification) {
        print("ChatManager :: notification :: \(notification.userInfo ?? [:])")
        print("ChatManager :: notification :: data :: \(notification.userInfo?["data"])")
        if managedObjectContext != nil {
            let array: Array = notification.userInfo?["data"] as! Array<Any>
            print("ChatManager :: notification :: string :: \(array[0])")
            let string = array[0] as! String
            let data = string.data(using: .utf8)!
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any> {
                    print(jsonObj) // use the json here
                    let message = Messages(context: managedObjectContext!)
                    message.id = UUID(uuidString: jsonObj["id"] as! String)
                    message.text = jsonObj["text"] as? String
                    message.from = jsonObj["participant"] as? String
                    message.participant = jsonObj["from"] as? String
                    message.sent = false
                    message.date = Date()
                    message.status = "received"
                    do {
                        try managedObjectContext?.save()
                        //
                        var chat: ChatHistory!
                        let fetchMessage: NSFetchRequest<ChatHistory> = ChatHistory.fetchRequest()
                        fetchMessage.predicate = NSPredicate(format: "participant = %@", message.participant!)
                        let results = try? managedObjectContext?.fetch(fetchMessage)
                        if results?.count == 0 {
                            // here you are inserting
                            chat = ChatHistory(context: managedObjectContext!)
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
                        try managedObjectContext?.save()
                    } catch (let error) {
                        print("Send Message :: error :: \(error)")
                    }
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    @objc func receivedKeyNotification(notification: Notification) {
        print("ChatManager :: notification :: \(notification.userInfo ?? [:])")
        print("ChatManager :: notification :: data :: \(notification.userInfo?["data"])")
        if managedObjectContext != nil {
            let array: Array = notification.userInfo?["data"] as! Array<Any>
            print("ChatManager :: notification :: string :: \(array[0])")
            let string = array[0] as! String
            let data = string.data(using: .utf8)!
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any> {
                    print(jsonObj) // use the json here
//                    let from = jsonObj["participant"] as? String
                    let participant = jsonObj["from"] as? String
                    let status = jsonObj["status"] as? Bool
                    let temp = chatDetailedViewModel?.participant
                    print("chatDetailedViewModel?.participant :: \(temp)")
                    if temp! == participant {
                        chatDetailedViewModel?.isTyping = status ?? false
                    }
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
