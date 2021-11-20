//
//  RegisterView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 19/11/2564 BE.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var username = ""
    @State var fullname = ""
    @State var password = ""
    @State var goBackLoginPage = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVStack {
                    Image("reddit-top")
                }
                .padding(.bottom, 24)
                
                VStack(alignment: .leading) {
                    Text("Create a account")
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
                    CustomTextField(placeholder: Text("FullName"), text: $fullname)
                        .padding()
                        .padding(.horizontal, 32)
                    CustomTextField(placeholder: Text("Username"), text: $username)
                        .padding()
                        .padding(.horizontal, 32)
                    CustomSecureField(placeholder: Text("Password"), text: $password)
                        .padding()
                        .padding(.horizontal, 32)
                }
                .navigationBarHidden(true)
                
                HStack {
                    Text("Already a Redditor?")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                    NavigationLink(destination: LoginView().navigationBarHidden(true)) {
                            Text("Log in")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding(.trailing, 28)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {
                    viewModel.register(withEmail: email, password: password, username: username, fullname: fullname)
                    goBackLoginPage = true
                } , label : {
                   Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding()
                })
                .disabled(email.isEmpty || username.isEmpty || fullname.isEmpty || password.isEmpty)
                NavigationLink(destination: LoginView().navigationBarHidden(true),isActive: $goBackLoginPage) {
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
