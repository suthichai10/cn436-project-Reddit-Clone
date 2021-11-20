//
//  MainView.swift
//  Reddit-Clone
//
//  Created by Kunatip Satsomnuk on 20/11/2564 BE.
//

import SwiftUI

struct MainView: View {
    @State var user: User
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem { Image(systemName: "house") }
                    .tag(0)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag(1)
                
                PostView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem { Image(systemName: "plus") }
                    .tag(2)
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem { Image(systemName: "person.circle") }
                    .tag(3)
                
                NotificationView()
                    .onTapGesture {
                        selectedIndex = 4
                    }
                //person.crop.circle.fill
                    .tabItem { Image(systemName: "bell") }
                    .tag(4)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:tabTitle, trailing: logOutButton)
            .accentColor(.black)
        }
    }
    
    var logOutButton: some View {
        Button {
            AuthViewModel.shared.signOut()
        } label: {
            Text("Log Out")
                .foregroundColor(.black)
        }
    }
    
    var tabTitle: some View {
        Text(tabTitleChoose)
            .font(.title2)
    }
    
    var tabTitleChoose: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Search"
        case 2: return "Create"
        case 3: return "Profile"
        case 4: return "Notification"
        default: return ""
        }
    }
}
