//
//  Anime.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/22/22.
//

import Foundation

struct Anime: Codable {
    var id: Int
    var title: String
    var main_picture: AnimeMainPicture
    var num_episodes: Int
    var genres: [AnimeGenre]
    var mean: Float
    var rank: Int
    var start_season: AnimeSeason
    var synopsis: String
    
    struct AnimeMainPicture: Codable {
        var medium: String
    }
    struct AnimeGenre: Codable {
        var name: String
    }
    struct AnimeSeason: Codable {
        var year: Int
        var season: String
    }
}

struct AnimeCollection: Codable {
    var data: [AnimeNode]
    
    struct AnimeNode: Codable {
//        var id: UUID = UUID()
        var node: Anime
    }
}

extension AnimeCollection {
    static let sampleData: [AnimeNode] =
    [
        AnimeNode(
            node: Anime(
                id: 21,
                title: "One Piece",
                main_picture: Anime.AnimeMainPicture(medium: "https://api-cdn.myanimelist.net/images/anime/6/73245.jpg"),
                num_episodes: 973,
                genres: [Anime.AnimeGenre(name: "Action"), Anime.AnimeGenre(name: "Adventure")],
                mean: 8.42,
                rank: 152,
                start_season: Anime.AnimeSeason(year: 2015, season: "spring"),
                synopsis: "Gol D. Roger was known as the Pirate King, the strongest and most infamous being to have sailed the Grand Line. The capture and execution of Roger by the World Government brought a change throughout the world. His last words before his"
            )
        )
    ]
}

