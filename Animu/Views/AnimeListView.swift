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
    @State private var toggleLarge = true
    
    var body: some View {
        List {
            Toggle("Display Card", isOn: $toggleLarge)
            ForEach(Array(animeStore.animeCollection.data.enumerated()), id: \.offset) { index, anime in
                NavigationLink(destination: AnimeDetailView(anime: anime.node)) {
                    if toggleLarge {
                        AnimeSearchItem(anime: anime.node)
                    } else {
                        HStack {
                            Text("\(index + 1).")
                                .foregroundColor(.secondary)
                            Text(anime.node.title)
                                .lineLimit(1)
                            Spacer()
                            Text(String(format: "%.2f", anime.node.mean))
                                .padding(4)
                                .foregroundColor(.white)
                                .background(.indigo)
                                .cornerRadius(4)
                        }
                    }
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
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimeListView()
                .environmentObject(AnimeStore())
        }
    }
}
