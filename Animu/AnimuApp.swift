//
//  AnimuApp.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import SwiftUI

@main
struct AnimuApp: App {
    @StateObject private var animeStore = AnimeStore()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AnimeListView()
                    .environmentObject(animeStore)
                    .onAppear {
                        // Fetch user's anime
                    }
            }
        }
    }
}
