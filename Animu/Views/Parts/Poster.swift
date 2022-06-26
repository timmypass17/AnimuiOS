//
//  Poster.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/24/22.
//

import SwiftUI

struct Poster: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                    .overlay {
                        RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).stroke(.white)
                    }
                    .shadow(radius: 5)

            } else if phase.error != nil {
                Color.red
            } else {
                // might use gray placeholder
                ProgressView()
//                Image("poster_sample")  // for testing
//                    .resizable()
//                    .scaledToFit()
//                    .cornerRadius(15)
//                    .shadow(radius: 5)
            }
        }
    }
}

struct Poster_Previews: PreviewProvider {
    static var previews: some View {
        let url: URL? = URL(string: AnimeCollection.sampleData[0].node.main_picture.medium)
        Poster(url: url!)
    }
}
