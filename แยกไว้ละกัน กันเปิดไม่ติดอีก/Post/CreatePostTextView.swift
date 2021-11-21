//
//  CreatePostTextView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct CreatePostTextView: View {
    @State var text = ""
    @State var selection: String?
    
    let names = [
        "r/com",
        "r/com1",
        "r/com2",
        "r/com3"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVStack {
                    Image("reddit-top")
                }
                .padding(.bottom, 24)
                
                VStack {
                    Text("Community Name")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.bottom, 10)
                }
                VStack(spacing: -16) {
                    TextArea("Enter your Text...", text: $text)
                        .padding()
                }
                .navigationBarHidden(true)
                
                NavigationView {
                    List(names, id: \.self, selection: $selection) { name in
                        Text(name)
                    }
                    .navigationBarHidden(true)
                    .padding()
                }
                
                Spacer()
                
                Button {
                } label: {
                    Text("Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(check ? LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(check)
                
                NavigationLink(
                    destination: PostView().navigationBarHidden(true),
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
    
    var check : Bool {
        if text == "" {
            return true
        } else {
            return false
        }
    }
}

struct CreatePostTextView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostTextView()
    }
}
