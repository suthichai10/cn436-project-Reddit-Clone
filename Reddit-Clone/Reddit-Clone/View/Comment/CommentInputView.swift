//
//  CommentInputView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct CommentInputView: View {
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color.black)
                .frame(width: UIScreen.main.bounds.width, height: 0.8)
            
            HStack {
                TextField("Add Comment", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action) {
                    Text("Send")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 40)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding(.trailing, 2)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}
