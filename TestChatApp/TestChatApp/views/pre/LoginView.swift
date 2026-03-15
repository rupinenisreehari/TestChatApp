//
//  ContentView.swift
//  TestChatApp
//
//  Created by Alex Antony Vijay J on 21/04/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var router = Router.shared
    @ObservedObject var loginViewModel = LoginViewModel()
    @State var email: String = ""
    @State var password: String = "TestChatApp"
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("User Login")
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
                    loginViewModel.login(username: email, password: password) { error in
                        if (error.code == 200) {
                            router.path.append("login")
                        } else {
                            print("Invalid Credential")
                        }
                    }
                } label: {
                    Text("LOGIN")
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
                .alert("Alert", isPresented: $loginViewModel.showAlert, presenting: loginViewModel.error) { error in
                    
                } message: { error in
                    Text(error.message.isEmpty ? "An error occurred" : error.message)
                }
                // signup button
                Button {
                    router.path.append("signup")
                    print("Path count :: \(router.path.count)")
                } label: {
                    Text("Signup")
                        .underline()
                        .foregroundColor(.black)
                        .padding(.top, 20)
                }
            }
            .padding()
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationDestination(for: String.self) { item in
                if (item == "signup") {
                    SignupView()
                } else {
                    ChatHistoryView()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
