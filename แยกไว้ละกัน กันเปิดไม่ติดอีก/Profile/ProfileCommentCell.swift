//
//  ProfileCommentCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 21/11/2564 BE.
//

import SwiftUI

struct ProfileCommentCell: View {
    @ObservedObject var viewModel : UserCommentViewModel
    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(viewModel.comment.username)
                    .font(.system(size: 18, weight: .semibold))
                Text("\(viewModel.comment.timestamp)")
                Text(viewModel.comment.commentText)
            }
            .padding(.leading, 10)
        }
    }
}

