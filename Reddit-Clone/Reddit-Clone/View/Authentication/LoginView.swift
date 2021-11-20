//
//  LoginView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 19/11/2564 BE.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
            NavigationView {
                VStack {
                    LazyVStack {
                        Image("reddit-top")
                    }
                    .padding(.bottom, 24)
                    
                    VStack(alignment: .leading) {
                        Text("Log in to Reddit")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.bottom, 10)
                        Text("By continuing, you agree to our User Agreement and Privacy Policy")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    VStack(spacing: -16) {
                        CustomTextField(placeholder: Text("Email"), text: $email)
                            .padding()
                            .padding(.horizontal, 32)
                        CustomSecureField(placeholder: Text("Password"), text: $password)
                            .padding()
                            .padding(.horizontal, 32)
                    }
                    .navigationBarHidden(true)
                    
                    HStack {
                        Text("New to Reddit?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                        NavigationLink(
                            destination: RegisterView().navigationBarHidden(true),
                            label: {
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 28)
                            }
                        )
                        
                    Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    HStack {
                        NavigationLink(
                            destination: ForgotPasswordView(email: $email).navigationBarHidden(true),
                            label: {
                                Text("Forgot Password")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding(.top)
                                    .padding(.trailing, 28)
                            }
                        )
                        
                    Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                            .padding()
                    }
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
