//
//  PostView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct PostView: View {

    var body: some View {
        NavigationView {
            VStack {
                LazyVStack {
                    Image("reddit-top")
                }
                .padding(.bottom, 24)
                
                VStack {
                    Text("Create a post or community")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.bottom, 10)
                    Text("Post somthing to reddit or create your community")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: CreatePostView().navigationBarHidden(true),
                    label: {
                        Text("Create a post")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                            .padding()
                    }
                )
                
                NavigationLink(
                    destination: CreateComView().navigationBarHidden(true),
                    label: {
                        Text("Create a community")
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
