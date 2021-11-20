//
//  FeedView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct FeedView: View {
    //@ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<9) { _ in
                    FeedCell()
                    Divider()
                     .frame(height: 8)
                     .background(Color.gray)
                    //FeedCell(viewModel: FeedCellViewModel(post: post))
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
