//
//  ProfileView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct ProfileView: View {
    @State var user : User
    var body: some View {
        VStack {
            LazyVStack {
                LazyVStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                            Image("reddit-top")
                                .resizeTo(width: 90, height: 90)
                                .clipShape(Circle())
                            Text("\(user.fullname)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.bottom, 3)
                            Text("u/\(user.username)")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(.bottom, 3)
                        }
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: RegisterView().navigationBarHidden(true),
                            label: {
                                Text("Edit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 50)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                                    .clipShape(Capsule())
                                    .padding()
                            }
                        )
                    }
                }
                .padding()
            }
            .frame(height: 200)
            .background(Color.gray)
            
            LazyVStack (alignment: .leading) {
                Text("Your Post")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 15)
            }
            Divider()
             .frame(height: 8)
             .background(Color.gray)
            
            Spacer()
            
            FeedView()
            
        }
    }
}
