//
//  ProflieCommentFeed.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 21/11/2564 BE.
//

import SwiftUI

struct ProflieCommentFeed: View {
    @ObservedObject var viewModel = UserCommentViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.comments) { comment in
                    ProfileCommentCell(viewModel: UserCommentViewModel(comment: comment))
                    Divider()
                     .frame(height: 2)
                     .background(Color.gray)
                }
            }
        }
    }
}

