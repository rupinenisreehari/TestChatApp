//
//  SignupViewModel.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

class SignupViewModel: ObservableObject {
    private var firebaseAuthService = FirebaseAuthService()
    @Published var error: AppError?
    @Published var showAlert: Bool = false
    
    func signup(username: String, password: String, completion: @escaping (AppError) -> Void) {
        firebaseAuthService.signUp(email: username, password: password) { [weak self] error in
            self?.showAlert = (error.code != 200)
            self?.error = error
            if (error.code == 200) {
                print("SignupViewModel :: singup :: success :: \(error.message)")
            } else {
                print("SignupViewModel :: singup :: error :: \(error.message)")
            }
            completion(error)
        }
    }
}
