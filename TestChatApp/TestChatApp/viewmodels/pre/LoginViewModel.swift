//
//  LoginViewModel.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    private var firebaseAuthService = FirebaseAuthService()
    @Published var error: AppError?
    @Published var showAlert: Bool = false
    
    func login(username: String, password: String, completion: @escaping (AppError) -> Void) {
        firebaseAuthService.signIn(email: username, password: password) { [weak self] error in
            self?.showAlert = (error.code != 200)
            self?.error = error
            if (error.code == 200) {
                print("LoginViewModel :: login :: success :: \(error.message)")
                UserDefaults.standard.set(username, forKey: "username")
            } else {
                print("LoginViewModel :: login :: error :: \(error.message)")
            }
            completion(error)
        }
    }
    
}
