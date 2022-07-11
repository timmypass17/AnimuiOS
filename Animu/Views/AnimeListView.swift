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
            ForEach(animeStore.animeCollection.data, id: \.node.id) { anime in
                NavigationLink(destination: AnimeDetailView(anime: anime.node)) {
                    if toggleLarge {
                        AnimeSearchItem(anime: anime.node)
                    } else {
                        HStack {
                            Text(anime.node.title)
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
