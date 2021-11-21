//
//  NotificationCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct NotificationCell: View {
    var notification : Notification
    
    var body: some View {
        
        LazyVStack(alignment: .leading){
            HStack {
                Image("reddit-top")
                    .resizeTo(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack {
                        Text("u/\(notification.username)")
                            .font(.system(size: 16, weight: .semibold))
                        Text(notification.timestampText())
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                    Text(notification.type.notificationMessage)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
            .padding(.leading, 20)
        }
    }
}
