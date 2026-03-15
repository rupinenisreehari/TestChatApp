//
//  Router.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 24/04/25.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    static let shared: Router = Router()
}
