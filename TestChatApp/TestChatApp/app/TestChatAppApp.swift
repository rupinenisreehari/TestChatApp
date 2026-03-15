//
//  TestChatAppApp.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI
import CoreData

@main
struct TestChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext,
                              CoreDataHelper.shared.persistentContainer.viewContext)
        }
    }
}
