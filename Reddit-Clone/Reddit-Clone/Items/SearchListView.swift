//
//  SearchListView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct SearchListView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var data: [Data] {
        //searchText.isEmpty ? viewModel.data : viewModel.filterData(withText: searchText)
        searchText.isEmpty ? viewModel.data : viewModel.data
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<data.count) { index in
                    switch data[index] {
                    case .RedditUser(user: let user):
                        NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user:user))) {
                            SearchCell(data:data[index])
                        }
                    case .RedditGroup(group: let group) :
                        NavigationLink(destination: GroupView(groupCell: GroupCellViewModel(group: group))) {
                            SearchCell(data:data[index])
                        }
                    }
                    Divider()
                }
            }
        }
    }
}
