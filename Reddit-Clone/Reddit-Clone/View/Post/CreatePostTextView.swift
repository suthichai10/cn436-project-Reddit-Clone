//
//  CreatePostTextView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct CreatePostTextView: View {
    @ObservedObject var viewModel : UploadPostViewModel
    @State var text = ""
    @State var selection: String?
    var groupName : String? = ""
    var groupID : String? = ""
    
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
                
                Spacer()
                
                Button {
                    viewModel.uploadPost(caption: text, groupID: groupID, groupName: groupName)
                } label: {
                    Text("Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(text.isEmpty ? LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(text.isEmpty)
                
                NavigationLink(
                    destination: PostView(viewModel:UploadPostViewModel(postType: viewModel.postType),groupName: "",groupID: "").navigationBarHidden(true),
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
