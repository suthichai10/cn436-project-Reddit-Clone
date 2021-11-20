//
//  NotificationCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct NotificationCell: View {
    @State var didLike = false
    
    var body: some View {
        
        LazyVStack(alignment: .leading){
            HStack {
                Image("reddit-top")
                    .resizeTo(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack {
                        Text("r/pernona")
                            .font(.system(size: 16, weight: .semibold))
                        Text("- 2h")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                    Text("Im die thank forever")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
            .padding(.leading, 20)
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
