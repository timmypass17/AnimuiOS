//
//  AnimeDetailView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/22/22.
//

import SwiftUI
import FirebaseAuth
import AVFoundation

struct AnimeDetailView: View {
    @EnvironmentObject var animeStore: AnimeStore
    @State private var isPresentingCreateReview = false
    @State private var isExpanded = false
    let anime: Anime

    var body: some View {
        // spacing: 0 to have more control for padding
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Poster(url: URL(string: anime.main_picture.large))
                    .frame(width: 150, height: 240)
                HStack {
                    Text(anime.title)
                        .font(.title)
                    Text(String(format: "%.2f", anime.mean))
                        .padding(4)
                        .foregroundColor(.white)
                        .background(.indigo)
                        .cornerRadius(4)
                }
                .padding(.top)
                Text(anime.synopsis)
                    .foregroundColor(.secondary)
                    .lineLimit(isExpanded ? nil : 4)
                    .padding(.bottom)
                    .onTapGesture {
                        isExpanded.toggle()
                    }
                
                HStack {
                    Text("Genre:")
                    ForEach(anime.genres.prefix(4), id: \.name) { genre in
                        if genre == anime.genres.last {
                            Text("\(genre.name)")
                        } else {
                            Text("\(genre.name),")
                        }
                    }
                    .foregroundColor(.secondary)
                }
                HStack {
                    Text("Release:")
                    Text(verbatim: "\(anime.start_season.season) \(anime.start_season.year)".capitalized)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Studio:")
                    ForEach(anime.studios, id: \.name) { studio in
                        if studio == anime.studios.last {
                            Text("\(studio.name)")
                        } else {
                            Text("\(studio.name),")
                        }
                    }
                    .foregroundColor(.secondary)
                }
                Divider()
                    .padding([.top, .bottom])
                Text("Reviews (\(animeStore.reviewCollection.reviews.count))")
                    .font(.title2)
                if animeStore.reviewCollection.reviews.count == 0 {
                    Text("Be the first to review!")
                        .foregroundColor(.secondary)
                } else {
                    // List of reviews
                    ForEach(animeStore.reviewCollection.reviews, id: \.self) { review in
                        ReviewItem(review: review)
                            .padding(.top)
                    }
                }
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isPresentingCreateReview) {
                NavigationView {
                    CreateReviewView(newReview: $animeStore.currentReview, isPresentingCreateReview: $isPresentingCreateReview, anime: anime)
                        .navigationTitle(anime.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingCreateReview = false
                                }
                            }
                            ToolbarItem(placement: .destructiveAction) {
                                Button(action:  {
                                    animeStore.deleteReview(anime: anime)
                                    animeStore.currentReview = Review()
                                    isPresentingCreateReview = false
                                    
                                }) {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresentingCreateReview = true }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isFavorited(anime: anime) {
                            animeStore.removeAnime(anime: anime)
                        } else {
                            animeStore.addAnime(anime: anime)
                        }
                    }) {
                        Image(systemName: isFavorited(anime: anime) ? "heart.fill": "heart")
                    }
                }
            }
            .navigationTitle(anime.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                animeStore.refreshReviews(anime: anime)
            }
        }
        .onDisappear {
            // reset state variables
            animeStore.reviewCollection = ReviewCollection()
            animeStore.currentReview = Review()
        }
    }
    
    func isFavorited(anime: Anime) -> Bool {
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
                .environmentObject(AnimeStore())
        }
    }
}

