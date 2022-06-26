//
//  AnimeList.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import SwiftUI

struct AnimeListView: View {
    @EnvironmentObject var animeStore: AnimeStore
    @State private var searchText: String = ""

    var body: some View {
        List {
            ForEach(animeStore.animeCollection.data, id: \.node.id) { anime in
                NavigationLink(destination: AnimeDetailView(anime: anime.node)) {
                    AnimeSearchItem(anime: anime.node)
                }
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText, prompt: "Search by title")
        .onSubmit(of: .search) {
            print("onSubmit: \(searchText)")
            Task {
                // Filter user's list
            }
        }
        .navigationTitle("My Anime List")
        .searchable(text: $searchText)
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
