//
//  SearchView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    //@ObservedObject var viewModel = SearchViewModel()
    
    @State var searchText = ""
    @State var inSearchMode = false
    var body: some View {
        //ScrollView {
            
         //   SearchBar(text: $searchText, isEditing: $inSearchMode)
          //      .padding()
            
           // ZStack {
            //    if inSearchMode {
             //       SearchListView(viewModel: viewModel, searchText: $searchText)
             //   }
          //  }
        //}
        ScrollView {
            LazyVStack {
                ForEach(0..<viewModel.data.count) { index in
                    switch viewModel.data[index] {
                    case .RedditUser(user: let user):
                        NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user:user))) {
                            SearchCell(data:viewModel.data[index])
                        }
                    case .RedditGroup(group: let group) :
                        NavigationLink(destination: GroupView(groupCell: GroupCellViewModel(group: group))) {
                            SearchCell(data:viewModel.data[index])
                        }
                    }
                    Divider()
                }
            }
        }
    }
}

