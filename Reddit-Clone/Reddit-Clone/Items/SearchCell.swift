//
//  SearchCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct SearchCell: View {
    var data: Data
    
    var body: some View {

        LazyVStack(alignment: .leading) {
            switch data {
            case .RedditUser(user: let user):
                
                HStack {
                    if let imageURL = user.profileImageURL {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 36 , height: 36)
                            .clipShape(Circle())
                    } else {
                    Image("default")
                        .resizeTo(width: 36, height: 36)
                        .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("u/\(user.username)")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                }
                .padding(.leading, 20)
            case .RedditGroup(group: let group):

                HStack {
                    if let imageURL = group.groupImageURL {
                        KFImage(URL(string: imageURL))
                            .resizeTo(width: 36, height: 36)
                            .clipShape(Circle())
                    } else {
                    Image("reddit-top")
                        .resizeTo(width: 36, height: 36)
                        .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("r/\(group.groupname)")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                }
                .padding(.leading, 20)
            }
        }
    }
}

