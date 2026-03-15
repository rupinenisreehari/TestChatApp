//
//  FirebaseAuthService.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthService {
    
    func signUp(email: String, password: String, completion: @escaping (AppError) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("FirebaseAuthService :: Signup error: \(error)")
                let err = AppError(message: error.localizedDescription, code: 4020)
                completion(err)
                return
            }
            print("FirebaseAuthService :: signUp :: Result :: \(result?.user.uid)")
            let err = AppError(message: result!.user.uid, code: 200)
            completion(err)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (AppError) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("FirebaseAuthService :: Login error: \(error)")
                let err = AppError(message: error.localizedDescription, code: 4020)
                completion(err)
                return
            }
            print("FirebaseAuthService :: signIn :: Result :: \(result?.user.uid)")
            let err = AppError(message: result!.user.uid, code: 200)
            completion(err)
        }
    }
}
