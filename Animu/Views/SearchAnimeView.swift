//
//  EditAnimeView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/22/22.
//

import SwiftUI

struct SearchAnimeView: View {
    @EnvironmentObject var animeStore: AnimeStore
    @State private var searchText: String = ""

    var body: some View {
        List {
            ForEach(animeStore.searchCollection.data, id: \.node.id) { anime in
                NavigationLink(destination: AnimeDetailView(anime: anime.node)) {
                    AnimeSearchItem(anime: anime.node)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Search Animes")
        .searchable(text: $searchText, prompt: "Search by title")
        .onSubmit(of: .search) {
            Task {
                try await animeStore.fetchAnime(title: searchText)
            }
        }
    }
}

struct SearchAnimeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchAnimeView()
                .environmentObject(AnimeStore())
        }
    }
}
