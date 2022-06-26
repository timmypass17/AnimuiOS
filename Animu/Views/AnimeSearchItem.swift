//
//  AnimeSearchItem.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/24/22.
//

import SwiftUI

struct AnimeSearchItem: View {
    let anime: Anime
    
    var body: some View {
        HStack {
            Poster(url: URL(string: anime.main_picture.medium))
                .frame(width: 110, height: 170)
                .padding([.trailing], 4)
            VStack(alignment: .leading) {
                Text(verbatim: "\(anime.start_season.season) \(anime.start_season.year)".capitalized)
                    .foregroundColor(.secondary)
                Text(anime.title)
                    .font(.headline)
                HStack {
                    ForEach(anime.genres.prefix(2), id: \.name) { genre in
                        Text("\(genre.name) |")
                            .foregroundColor(.secondary)
                    }
                }
                .padding([.bottom], 2)
                Text(anime.synopsis)
                    .lineLimit(4)
            }
        }
    }
}

struct AnimeSearchItem_Previews: PreviewProvider {
    static var previews: some View {
        AnimeSearchItem(anime: AnimeCollection.sampleData[0].node)
            .previewLayout(.sizeThatFits)
    }
}
