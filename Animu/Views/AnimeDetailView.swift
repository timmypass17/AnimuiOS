//
//  AnimeDetailView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/22/22.
//

import SwiftUI

struct AnimeDetailView: View {
    @EnvironmentObject var animeStore: AnimeStore
    let anime: Anime
    var body: some View {
        List {
            Section(header: Text("Description")) {
                HStack {
                    Label("Title", systemImage: "timer")
                    Spacer()
                    Text(anime.title)
                }
                HStack {
                    Label("Episodes", systemImage: "timer")
                    Spacer()
                    Text("\(anime.num_episodes)") // 0 if ongoing
                }
                HStack {
                    Label("Genre", systemImage: "timer")
                    Spacer()
                    ForEach(anime.genres.prefix(2), id: \.name) { genre in
                        Text(genre.name)
                    }
                }
            }
            Section(header: Text("Statistics")) {
                HStack {
                    Label("Rating", systemImage: "timer")
                    Spacer()
                    Text(String(format: "%.2f", anime.mean))
                }
                HStack {
                    Label("Rank", systemImage: "timer")
                    Spacer()
                    Text("\(anime.rank)")
                }
            }
            Button("Remove Anime", role: .destructive) { animeStore.removeAnime(anime: anime) }
            .disabled(!containsAnime(anime: anime))
        }
        .navigationTitle(anime.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { animeStore.addAnime(anime: anime) }) {
                    Image(systemName: "plus")
                }
                .disabled(containsAnime(anime: anime))
            }
        }

    }
    
    func containsAnime(anime: Anime) -> Bool {
        for node in animeStore.animeCollection.data {
            if node.node.id == anime.id {
                return true
            }
        }
        return false
    }
}



struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimeDetailView(anime: AnimeCollection.sampleData[0].node)
        }
    }
}
