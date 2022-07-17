//
//  CreateReviewView.swift
//  Animu
//
//  Created by Timmy Nguyen on 7/6/22.
//

import SwiftUI

struct CreateReviewView: View {
    @EnvironmentObject var animeStore: AnimeStore
    @Binding var newReview: Review
    @Binding var isPresentingCreateReview: Bool
    let anime: Anime
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image("waddle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                    .overlay {
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).stroke(.white)
                    }
                VStack(alignment: .leading) {
                    Text(animeStore.currentUser.name)
                    Text("@\(animeStore.currentUser.username)")
                        .foregroundColor(.secondary)
                }
            }
            TextEditor(text: $newReview.review)
                .border(.secondary)
                .frame(height: 200)
                .cornerRadius(4)
            HStack {
                Text("Overall Rating:")
                TextField("8.5", text: $newReview.rating)
            }
//            HStack {
//                Spacer()
//                Text("200 characters remaining")
//            }
            Button(action: {
                animeStore.addReview(anime: anime, review: newReview)
                isPresentingCreateReview = false
            }) {
                HStack {
                    Spacer()
                    Text("Write a Review")
                    Spacer()
                }
            }
            .contentShape(Rectangle())
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(4)
            .padding(.top)
            
            Spacer()
//            HStack {
//                Spacer()
//                Button("Remove", role: .destructive) {
//                    animeStore.deleteReview(anime: anime)
//                    newReview = Review()
//                    isPresentingCreateReview = false
//                }
//                .foregroundColor(.secondary)
//                Spacer()
//            }
        }
        .padding()
    }
}

struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleReview = Review(rating: "8.5", review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        CreateReviewView(newReview: .constant(sampleReview), isPresentingCreateReview: .constant(true), anime: AnimeCollection.sampleData[0].node)
            .preferredColorScheme(.dark)
    }
}
