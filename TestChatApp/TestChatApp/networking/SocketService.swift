//
//  SocketService.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 23/04/25.
//

import Foundation
import SocketIO

class SocketService {
    private var socketManager: SocketManager?
    private var socket: SocketIOClient?
    
    init() {
        // Create a Socket.IO manager instance
        socketManager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
    }
    
    func isConnected() -> Bool {
        print("SocketService :: isConnected")
        if socket != nil {
            return socket?.status == .connected
        }
        return false
    }
    
    func connectToServer(username: String) {
        print("SocketService :: connectToServer :: \(username)")
        // Create a Socket.IO client
        socket = socketManager?.defaultSocket
        //
        if socket != nil {
            socket!.on(clientEvent: .connect) { [weak self] data, ack in
                print("Socket connected")
                self?.socket!.emit("startchat", username) {
                    print("Socket :: emit :: startchat")
                }
            }
            socket!.on(clientEvent: .disconnect) { data, ack in
                print("Socket :: disconnect :: data :: \(data)")
            }
            socket!.on(clientEvent: .error) { data, ack in
                print("Socket :: error :: data :: \(data)")
            }
            socket!.on(clientEvent: .reconnect) { data, ack in
                print("Socket :: reconnect :: data :: \(data)")
            }
            socket!.on("receivemsg") { data, ack in
                print("Socket :: receivemsg :: data :: \(data)")
                let dict = ["data": data]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChatMessageReceived"), object: nil, userInfo: dict)
            }
            socket!.on("onKey") { data, ack in
                print("Socket :: receivemsg :: data :: \(data)")
                let dict = ["data": data]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "KeyboardStatusReceived"), object: nil, userInfo: dict)
            }
            socket!.connect()
        }
    }
    
    func sendMessage(message: String) -> Bool {
        print("SocketService :: sendMessage")
        if socket == nil {
            print("Socket :: sendMessage :: socket is nil")
            return false
        } else {
            socket?.emit("chatmsg", message) {
                print("Socket :: emit :: chatmsg")
            }
            return true;
        }
    }
    
    func sendTypingStatus(message: String) {
        print("SocketService :: sendTypingStatus")
        if socket == nil {
            print("Socket :: sendTypingStatus :: socket is nil")
        } else {
            socket?.emit("key", message) {
                print("Socket :: emit :: key")
            }
        }
    }
}
