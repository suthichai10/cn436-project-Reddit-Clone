//
//  SearchCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct SearchCell: View {
    //let user: User
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            //if let imageURL = user.profileImageURL {
             //   KFImage(URL(string: imageURL))
               //     .resizeTo(width: 48, height: 48)
                 //   .clipShape(Circle())
            //} else {
            HStack {
                Image("reddit-top")
                    .resizeTo(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack {
                        Text("r/pernona")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
            .padding(.leading, 20)
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell()
    }
}
