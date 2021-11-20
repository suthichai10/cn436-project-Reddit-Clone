//
//  FeedCell.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @State var didLike = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Image("reddit-top")
                    .resizeTo(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("r/pernona")
                        .font(.system(size: 18, weight: .semibold))
                    Text("Posted By u/Me - 3h")
                }
            }
            .padding(.leading, 10)
            
            Text("Hello man im die")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading, 5)
            Image("test")
                .resizable()
                .scaledToFit()
                .clipped()
            
            HStack {
                Button {
                    didLike.toggle()
                } label: {
                    Image(systemName: didLike ? "arrowtriangle.up.fill" : "arrowtriangle.up")
                        .resizeTo(width: 25, height: 25)
                        .foregroundColor(didLike ? .orange : .black)
                        .font(.system(size: 20))
                        .padding(.leading, 10)
                }
                Text("1")
                    .padding(.trailing, 50)
                Image(systemName: "plus.message")
                    .resizeTo(width: 25, height: 25)
                    .font(.system(size: 20))
                    .padding(.leading, 5)
                Text("Comment")
                    .padding(.trailing, 35)
                Image(systemName: "square.and.arrow.up")
                    .resizeTo(width: 23, height: 23)
                    .font(.system(size: 20))
                    .padding(.leading, 5)
                Text("Share")
                
            }
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
