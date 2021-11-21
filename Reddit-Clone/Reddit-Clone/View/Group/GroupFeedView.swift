//
//  GroupFeedView.swift
//  Reddit-Clone
//
//  Created by suthichai on 21/11/2564 BE.
//

import SwiftUI

struct GroupFeedView: View {
    @ObservedObject var viewModel : GroupCellViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post))
                    Divider()
                     .frame(height: 8)
                     .background(Color.gray)
                }
            }
        }
    }
}
