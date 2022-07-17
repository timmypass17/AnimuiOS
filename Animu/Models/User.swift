//
//  User.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/23/22.
//

import Foundation

/// Codable: For using firebase
struct User: Codable {
    var id: String
    var name: String
    var email: String
    var username: String
    var animeList: [AnimeCollection.AnimeNode]
    var friendList: [String]
    
    init(id: String = "", name: String = "", email: String = "", username: String = "", animeList: [AnimeCollection.AnimeNode] = [], friendList: [String] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
        self.animeList = animeList
        self.friendList = friendList
    }
}
