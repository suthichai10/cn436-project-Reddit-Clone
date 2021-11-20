//
//  ForgotPasswordView.swift
//  Instagram-clone
//
//  Created by Kunatip Satsomnuk on 7/11/2564 BE.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var email : String
    
    init(email: Binding<String>) {
        _email = email
    }
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVStack {
                    Image("reddit-top")
                }
                .padding(.bottom, 24)
                
                VStack(alignment: .leading) {
                    Text("Forgot your password?")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.bottom, 10)
                }
                
                VStack(spacing: -16) {
                    CustomTextField(placeholder: Text("Email"), text: $email)
                        .padding()
                        .padding(.horizontal, 32)
                }
                .navigationBarHidden(true)
                
                VStack(alignment: .leading) {
                    Text("Unfortunately, if you have never given us your email, \nwe will not beable to reset your password.")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                
                Button {
                } label: {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                }
                
                NavigationLink(
                    destination: LoginView().navigationBarHidden(true),
                    label: {
                        Text("Go Back")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                            .padding()
                    }
                )
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    
    @State static var value = ""
    
    static var previews: some View {
        ForgotPasswordView(email: $value)
    }
}
