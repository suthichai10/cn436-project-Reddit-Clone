//
//  FeedCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel : FeedCellViewModel
    var didLike : Bool {
        viewModel.post.didLike ?? false
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Image("reddit-top")
                    .resizeTo(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    if let groupName = viewModel.post.groupName {
                        Text("r/\(groupName)")
                            .font(.system(size: 18, weight: .semibold))
                        Text("Posted By u/\(viewModel.post.ownerUsername)")
                    } else {
                        Text("u/\(viewModel.post.ownerUsername)")
                            .font(.system(size: 18, weight: .semibold))
                    }

                }
            }
            .padding(.leading, 10)
            
            Text(viewModel.post.caption)
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 5)
            Image(viewModel.post.imageURL ?? "") // default image
                .resizable()
                .scaledToFit()
                .clipped()
            
            HStack {
                Button {
                    didLike ? viewModel.unlike() : viewModel.like()
                } label: {
                    Image(systemName: didLike ? "arrowtriangle.up.fill" : "arrowtriangle.up")
                        .resizeTo(width: 25, height: 25)
                        .foregroundColor(didLike ? .orange : .black)
                        .font(.system(size: 20))
                        .padding(.leading, 10)
                }
                Text("\(viewModel.post.likes)")
                    .padding(.trailing, 50)
 
                NavigationLink(destination: CommentsView(post:viewModel.post)) {
                    Image(systemName: "plus.message")
                        .resizeTo(width: 25, height: 25)
                        .font(.system(size: 20))
                        .padding(.leading, 5)
                    Text("Comment")
                        .padding(.trailing, 35)
                }
                
                Image(systemName: "square.and.arrow.up")
                    .resizeTo(width: 23, height: 23)
                    .font(.system(size: 20))
                    .padding(.leading, 5)
                Text("Share")
                
            }
        }
    }
}
