//
//  AnimuApp.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct AnimuApp: App {
    @StateObject private var animeStore = AnimeStore()
    @State private var selection: Tab = .list
    
    enum Tab {
        case list
        case discover
        case friends
    }
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if animeStore.isSignedIn {
                    TabView(selection: $selection) {
                        NavigationView {
                            AnimeListView()
                                .onAppear {
                                    // Fetch user's anime
                                    print("Calling loadAnimes()")
                                    animeStore.loadAnimes()
                                }
                        }
                        .tabItem { Label("List", systemImage: "list.bullet") }.tag(Tab.list)
                        
                        NavigationView {
                            SearchAnimeView()
                        }
                        .tabItem { Label("Discover", systemImage: "magnifyingglass") }.tag(Tab.discover)

                        NavigationView {
                            FriendListView()
                        }
                        .tabItem { Label("Friends", systemImage: "person.2.fill") }.tag(Tab.friends)
                    }
                } else {
                    NavigationView {
                        LoginView()                        
                    }
                }
            }
            .environmentObject(animeStore)
        }
    }
}
