//
//  GroupView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct GroupView: View {
    var body: some View {
        VStack {
            LazyVStack {
                LazyVStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                            Image("reddit-top")
                                .resizeTo(width: 90, height: 90)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
            }
            .background(Color.gray)
            
            LazyVStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("r/GroupName")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.bottom, 3)
                        Text("Hi im die")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: RegisterView().navigationBarHidden(true),
                        label: {
                            Text("Join")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 50)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                                .clipShape(Capsule())
                                .padding(.trailing, 2)
                        }
                    )
                }
            }
            .padding()
            
            LazyVStack (alignment: .leading) {
                Text("Post")
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

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
