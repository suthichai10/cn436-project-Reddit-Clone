//
//  CreateComView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct CreateComView: View {
    @ObservedObject var viewModel = GroupViewModel()
    @State var name = ""
    @State var description = ""
    
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
                    CustomTextField(placeholder: Text("r/Community_name"), text: $name)
                        .padding()
                        .padding(.horizontal, 32)
                    CustomTextField(placeholder: Text("description"), text: $description)
                        .padding()
                        .padding(.horizontal, 32)
                }
                .navigationBarHidden(true)
                
                Spacer()
                
                Button {
                    viewModel.createGroup(groupname: name, description: description)
                } label: {
                    Text("Create Community")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background((name.isEmpty || description.isEmpty) ? LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(name.isEmpty || description.isEmpty)
                
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
}
