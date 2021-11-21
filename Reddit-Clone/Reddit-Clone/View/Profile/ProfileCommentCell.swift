//
//  ProfileCommentCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 21/11/2564 BE.
//

import SwiftUI

struct ProfileCommentCell: View {
    var comment : Comment
    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(comment.username)
                    .font(.system(size: 18, weight: .semibold))
                Text(comment.timestampText())
                Text(comment.commentText)
            }
            .padding(.leading, 10)
        }
    }
}

