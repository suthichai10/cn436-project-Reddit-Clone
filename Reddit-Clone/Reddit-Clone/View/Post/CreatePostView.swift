//
//  CreatePostView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct CreatePostView: View {
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @State var selection: String?
    @ObservedObject var viewModel : UploadPostViewModel
    var groupName : String? = ""
    var groupID : String? = ""
    
    var body: some View {
        if postImage == nil {
            VStack {
                Image("reddit-top")
                    .padding(24)
                
                Text("Upload Post with Picture")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 10)
                
                Spacer()
                
                Button(action: {
                    imagePickerPresented.toggle()
                }) {
                    Text("Upload")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding()
                }
                .sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
                
                NavigationLink(
                    destination: PostView(viewModel: UploadPostViewModel(postType: viewModel.postType)).navigationBarHidden(true),
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
        } else if let image = postImage {
            VStack {
                HStack(alignment: .top) {
                    image
                        .resizeTo(width: 96, height: 96)
                        .clipped()
                    
                    TextArea("Enter your caption...", text: $captionText)
                }
                .padding()
                
                Button {
                    if let image = selectedImage {
                        viewModel.uploadPost(image: image, caption: captionText, groupID: groupID, groupName: groupName)
                        captionText = ""
                        postImage = nil
                    }
                } label: {
                    Text("Post")
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
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
