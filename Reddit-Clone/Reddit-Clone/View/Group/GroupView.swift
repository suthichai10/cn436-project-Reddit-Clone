//
//  GroupView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct GroupView: View {
    let groupCell : GroupCellViewModel
    
    var didFollow : Bool {
        groupCell.group.didFollow ?? false
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
                        }
                    }
                }
                .padding()
            }
            .background(Color.gray)
            
            LazyVStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("r/\(groupCell.group.groupname)")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.bottom, 3)
                        Text(groupCell.group.description)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    if groupCell.group.ownerID != AuthViewModel.shared.currentUser?.id {
                        Button {
                            didFollow ? groupCell.unfollow() : groupCell.follow()
                        } label: {
                            Text(didFollow ? "Joined" : "Join")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 50)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                                .clipShape(Capsule())
                                .padding(.trailing, 2)
                        }
                        
                    }
                    NavigationLink(destination: PostView(viewModel:UploadPostViewModel(postType: .group),groupName: groupCell.group.groupname , groupID: groupCell.group.id ?? "")) {
                        Text("Posts")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                            .padding(.trailing, 2)
                    }
                }
            }
            .padding()
            
            LazyVStack (alignment: .leading) {
                Text("Posts")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 15)
            }
            Divider()
             .frame(height: 8)
             .background(Color.gray)
            
            Spacer()
            
            GroupFeedView(viewModel:groupCell)
            
        }
    }
}
