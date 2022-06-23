//
//  AnimeList.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import SwiftUI

struct AnimeListView: View {
    @EnvironmentObject var animeStore: AnimeStore
    @State private var isPresentingNewAnimeView = false

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationTitle("Anime List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SearchAnimeView()
                    .environmentObject(animeStore)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimeListView()
        }
    }
}
