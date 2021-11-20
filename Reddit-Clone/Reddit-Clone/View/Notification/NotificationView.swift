//
//  NotificationView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<9) { _ in
                    NotificationCell()
                    Divider()
                    //FeedCell(viewModel: FeedCellViewModel(post: post))
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
