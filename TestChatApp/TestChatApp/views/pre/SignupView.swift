//
//  SignupView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Google Signup")
                .font(.system(size: 22, weight: .bold))
                .padding()
            TextField("Email", text: $email)
                .padding()
                .background(AppHelper.buttonBackgroundColor())
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                )
            SecureField("Password", text: $password)
                .padding()
                .background(AppHelper.buttonBackgroundColor())
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding(.top, 10)
            Button {
                signupViewModel.signup(username: email, password: password) { error in
                    if (error.code == 200) {
                        Router.shared.path.removeLast()
                    } else {
                        print("Invalid Credential")
                    }
                }
            } label: {
                Text("SIGNUP")
                    .font(.system(size: 18, weight: .bold))
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.top, 20)
            .alert("Alert", isPresented: $signupViewModel.showAlert, presenting: signupViewModel.error) { error in
                
            } message: { error in
                Text(error.message.isEmpty ? "An error occurred" : error.message)
            }
        }
        .padding()
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

//#Preview {
//    SignupView()
//}
