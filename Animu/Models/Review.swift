//
//  Review.swift
//  Animu
//
//  Created by Timmy Nguyen on 7/7/22.
//

import Foundation

// Hashable to use \.self for ForEach
struct Review: Codable, Hashable {
    var id: String
    var author: String
    var username: String
    var rating: String
    var review: String
    
    init(id: String = "", author: String = "", username: String = "", rating: String = "", review: String = "") {
        self.id = id
        self.author = author
        self.username = username
        self.rating = rating
        self.review = review
    }
}

struct ReviewCollection: Codable {
    var reviews: [Review]
    
    init(reviews: [Review] = []) {
        self.reviews = reviews
    }
}
