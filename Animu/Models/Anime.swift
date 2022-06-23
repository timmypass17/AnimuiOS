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
    
    struct AnimeMainPicture: Codable {
        var medium: String
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
        AnimeNode(node: Anime(id: 1, title: "One Piece", main_picture: Anime.AnimeMainPicture(medium: ""), num_episodes: 973)),
        AnimeNode(node: Anime(id: 2, title: "Spy x Family", main_picture: Anime.AnimeMainPicture(medium: ""), num_episodes: 12)),
        AnimeNode(node: Anime(id: 3, title: "Naruto", main_picture: Anime.AnimeMainPicture(medium: ""), num_episodes: 500))
    ]
}

