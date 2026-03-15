//
//  AppError.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import Foundation

struct AppError: LocalizedError {
    let message: String
    let code: Int
}
