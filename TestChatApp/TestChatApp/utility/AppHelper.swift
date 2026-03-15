//
//  AppHelper.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

class AppHelper {
    static func buttonBackgroundColor() -> Color {
        return Color(red: 245/255, green: 245/255, blue: 245/255)
    }
    
    static func timeFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
