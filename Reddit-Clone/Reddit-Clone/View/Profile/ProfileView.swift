//
//  ProfileView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel : ProfileViewModel
    var didFollow : Bool {
        viewModel.user.didFollow ?? false
    }
    var body: some View {
        VStack {
            LazyVStack {
                LazyVStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                            Image("reddit-top")
                                .resizeTo(width: 90, height: 90)
                                .clipShape(Circle())
                            Text("\(viewModel.user.fullname)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.bottom, 3)
                            Text("u/\(viewModel.user.username)")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(.bottom, 3)
                        }
                        Spacer()
                        if viewModel.user.id != AuthViewModel.shared.currentUser?.id {
                            Button {
                                didFollow ? viewModel.unfollow() : viewModel.follow()
                            } label: {
                                Text(didFollow ? "Following" : "Follow")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 50)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                                    .clipShape(Capsule())
                                    .padding(.trailing, 2)
                            }
                        }
                        
                    }
                    
                }
                .padding()
            }
            .frame(height: 200)
            .background(Color.gray)
            
            LazyVStack {
                HStack{
                    NavigationLink(
                        destination: ProfileView(viewModel: viewModel).navigationBarHidden(true),
                        label: {
                            Text("Post")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.leading, 25)
                        }
                    )
                    Spacer()
                    NavigationLink(
                        destination: ProfileCommentView(viewModel:viewModel).navigationBarHidden(true),
                        label: {
                            Text("Comment")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    )
                    Spacer()
                    NavigationLink(
                        destination: ProfileAboutView(viewModel:viewModel).navigationBarHidden(true),
                        label: {
                            Text("About")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.trailing, 25)
                        }
                    )
                }
            }
            Divider()
                .frame(height: 8)
                .background(Color.gray)
            
            Spacer()
            
            ProfileFeedView(viewModel:viewModel)
        }
        .navigationBarHidden(true)
        
        
        
    }
}
