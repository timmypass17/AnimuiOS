//
//  AnimeDetailView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/22/22.
//

import SwiftUI

struct AnimeDetailView: View {
    @Binding var anime: Anime
    var body: some View {
        VStack {
            
        }
        .navigationTitle(anime.title)
    }
}

struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: .constant(AnimeCollection.sampleData[0].node))
    }
}
