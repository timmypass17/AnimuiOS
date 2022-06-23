//
//  AnimeStore.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import Foundation

class AnimeStore: ObservableObject {
    @Published var animeCollection = AnimeCollection(data: [])
    
    // https://api.myanimelist.net/v2/anime?q=one&fields=num_episodes
    let baseUrl = "https://api.myanimelist.net/v2"
    
    enum FetchError: Error {
        case badRequest
        case badJson
    }
    
    func fetchAnime(title: String) async
    throws {
        guard let url = URL(string: "\(baseUrl)/anime?q=\(title)&fields=num_episodes") else { return }
        
        var request = URLRequest(url: url)
        let apiKey = "e7bc56aa1b0ea0afe3299d889922e5b8"
        request.setValue(apiKey, forHTTPHeaderField: "X-MAL-CLIENT-ID")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
             }
        Task { @MainActor in
            animeCollection = try JSONDecoder().decode(AnimeCollection.self, from: data)
            print(animeCollection.data.count)
        }
    }
}
