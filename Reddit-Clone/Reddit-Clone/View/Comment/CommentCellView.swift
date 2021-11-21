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
                     .resizeTo(width: 36, height: 36)
            VStack (alignment: .leading) {
                HStack {
                    KFImage(URL(string: comment.profileImageURL))
                     .resizeTo(width: 36, height: 36)
                     .clipShape(Circle())
                    
                    Text(comment.username)
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(comment.timestamp)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.trailing)
                    
                }
                Text(comment.commentText)
                        .foregroundColor(.gray)
            .padding(.leading)
            .padding(.leading)
    }



