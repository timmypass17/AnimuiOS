//
//  AnimeStore.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/21/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AnimeStore: ObservableObject {
    
    @Published var animeCollection = AnimeCollection(data: [])
    @Published var searchCollection = AnimeCollection(data: [])
    @Published var reviewCollection = ReviewCollection(reviews: [])
    @Published var isSignedIn = Auth.auth().currentUser != nil
    @Published var currentUser = User()
    @Published var currentReview = Review()
    
    // https://api.myanimelist.net/v2/anime?q=one&fields=num_episodes
    let baseUrl = "https://api.myanimelist.net/v2"
    
    enum FetchError: Error {
        case badRequest
        case badJson
    }
    
    func loadAnimes() {
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid
        
        // This line is important, app doesn't crash anymore because we don't call this func when user signs out
        guard isSignedIn else {
            print("User is not signed in")
            return
        }
        
        // 1. Get user's current list
        db.collection("users")
            .document(id ?? "")
            .getDocument { document, error in
                guard let document = document else { return }
                guard let currentUser = try? document.data(as: User.self) else { return }
                                
                // 2. Store anime list locally
                self.animeCollection = AnimeCollection(data: currentUser.animeList)
                print(self.animeCollection.data.count)
                self.currentUser = currentUser
            }
    }
    
    func addAnime(anime: Anime) {
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser!.uid
        
        // 1. Get user's current list
        db.collection("users")
            .document(id)
            .getDocument { document, error in
                guard let document = document else { return }
                guard var currentUser = try? document.data(as: User.self) else { return }
                
                let animeToAdd = AnimeCollection.AnimeNode(node: anime)
                // 2. Add new anime
                currentUser.animeList.append(animeToAdd)
                
                // 3. Update user's list in Firebase
                do {
                    try db.collection("users")
                        .document(id)
                        .setData(from: currentUser)
                    self.animeCollection.data.append(animeToAdd) // add to local collection to show live updates (i.e adding anime shows delete button)
                } catch {
                    print("Error adding \(anime.title)")
                }
            }
    }
    
    func removeAnime(anime: Anime) {
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser!.uid
        
        // 1. Get user's current list
        db.collection("users")
            .document(id)
            .getDocument { document, error in
                guard let document = document else { return }
                guard var currentUser = try? document.data(as: User.self) else { return }
                
                // 2. Remove anime
                var pos = 0
                for (i, n) in currentUser.animeList.enumerated() {
                    if n.node.id == anime.id {
                        pos = i
                        currentUser.animeList.remove(at: pos)
                        break
                    }
                }
                
                // 3. Update user's list in Firebase
                do {
                    try db.collection("users")
                        .document(id)
                        .setData(from: currentUser)
                    self.animeCollection.data.remove(at: pos)
                } catch {
                    print("Error adding \(anime.title)")
                }
            }
    }
    
    func fetchAnime(title: String) async
    throws {
        let titleFormatted = title.replacingOccurrences(of: " ", with: "_")
        print(titleFormatted)
        let fieldValue = "num_episodes,genres,mean,rank,start_season,synopsis,studios"
        guard let url = URL(string: "\(baseUrl)/anime?q=\(titleFormatted)&fields=\(fieldValue)") else { return }
        
        var request = URLRequest(url: url)
        let apiKey = "e7bc56aa1b0ea0afe3299d889922e5b8"
        request.setValue(apiKey, forHTTPHeaderField: "X-MAL-CLIENT-ID")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
             }
        Task { @MainActor in
            searchCollection = try JSONDecoder().decode(AnimeCollection.self, from: data)
            print(searchCollection.data.count)
        }
    }
    
    func signUp(name: String, username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.isSignedIn = true

            // Create user object to store into firebase
            let userData = User(id: user.uid, name: name, email: email, username: username.lowercased())
            
            // Add user to firebase
            do {
                let db = Firestore.firestore()
                try db.collection("users")
                    .document(user.uid)
                    .setData(from: userData)
            } catch {
                print("Error with signing user")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.isSignedIn = true
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
        } catch {
            print("already signed out")
        }
    }
    
    // 1. Read entire doc, modify array, write document back to firebase
    func addReview(anime: Anime, review: Review) {
        var updatedReview = review
        updatedReview.author = self.currentUser.name
        updatedReview.username = self.currentUser.username
        updatedReview.id = self.currentUser.id
        let docRef = Firestore.firestore().collection("reviews").document(String(anime.id))
        
        docRef
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            // 1. Get current reviews of anime
                            guard var currentReviews = try? document.data(as: ReviewCollection.self) else { return }
                            var userReviewedAlready = false
                            // 2. Look if user already review
                            for (i, item) in currentReviews.reviews.enumerated() {
                                // 3. If user reviewed already, replace that review with updated review
                                if item.id == self.currentUser.id {
                                    currentReviews.reviews[i] = updatedReview
                                    userReviewedAlready = true
                                    break
                                }
                            }
                            
                            // If user didnt review, append new review
                            if !userReviewedAlready {
                                currentReviews.reviews.append(updatedReview)
                                
                            }
                            
                            self.reviewCollection = currentReviews
                            self.currentReview = updatedReview
                            do {
                                try docRef.setData(from: currentReviews)
                            } catch {
                                print("Error updating review")
                            }
                            
                            }
                        else {
                            print("Document does not exist")
                        }
                    }
                } else {
                    print("Document does not exist, adding it")
                    // Add review
                    do {
                        self.reviewCollection = ReviewCollection(reviews: [updatedReview])
                        try docRef.setData(from: ReviewCollection(reviews: [updatedReview]), merge: true)
                    } catch {
                        print("Error adding review")
                    }

                }
            }
    }
    
    func refreshReviews(anime: Anime) {
        let db = Firestore.firestore()

        // 1. Get user's current list
        db.collection("reviews")
            .document(String(anime.id))
            .getDocument { document, error in
                guard let document = document else { return }
                guard let reviews = try? document.data(as: ReviewCollection.self) else { return }
                                
                // 2. Store anime list locally
                self.reviewCollection = reviews
                
                for review in reviews.reviews {
                    if review.id == self.currentUser.id {
                        self.currentReview = review
                    }
                }
                print("Current Review: \(self.currentReview)")
            }
    }
    
}
