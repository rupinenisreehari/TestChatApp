//
//  AppDelegate.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      print("AppDelegate :: application :: didFinishLaunchingWithOptions")
      FirebaseApp.configure()

    return true
  }
}
