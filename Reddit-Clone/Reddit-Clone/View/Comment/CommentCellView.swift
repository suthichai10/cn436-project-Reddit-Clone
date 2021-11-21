//
//  CommentCellView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            VStack (alignment: .leading) {
                HStack {
                    Image(comment.profileImageURL ?? "default")
                     .resizeTo(width: 36, height: 36)
                     .clipShape(Circle())
                    
                    Text(comment.username)
                        .font(.system(size: 14, weight: .semibold))
                    Text(comment.timestampText())
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.trailing)
                }
                Text(comment.commentText)
                        .foregroundColor(.gray)
                        .padding(.leading)
            }
        }
        .padding([.leading,.top] , 10)
    }
}


