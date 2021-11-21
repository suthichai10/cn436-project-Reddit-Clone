//
//  SearchListView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct SearchListView: View {
    
    //@ObservedObject var viewModel: SearchViewModel
    //@Binding var searchText: String
    
    //var users: [User] {
        //searchText.isEmpty ? viewModel.users : viewModel.filterUsers(withText: searchText)
    //}
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<9) { _ in
                    SearchCell()
                    Divider()
                    //NavigationLink(destination: ProfileView(user: user)) {
                        //UserCell(user: user)
                            //.padding(.leading, 8)
                    }
                }
            }
        }
}
struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
