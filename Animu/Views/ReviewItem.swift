//
//  ReviewItem.swift
//  Animu
//
//  Created by Timmy Nguyen on 7/6/22.
//

import SwiftUI

struct ReviewItem: View {
    @State var isExpanded = false
    let review: Review
    var body: some View {
        HStack(alignment: .top) {
            Image("waddle")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).stroke(.white)
                }
            VStack(alignment: .leading) {
                HStack {
                    Text(review.author)
                    Text("@\(review.username)")
                        .foregroundColor(.secondary)
                }
                Text("\"\(review.review)\"")
                    .lineLimit(isExpanded ? nil : 2)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        isExpanded.toggle()
                    }
            }
            Spacer()
            Text(review.rating)
                .padding(4)
                .foregroundColor(.white)
                .background(.indigo)
                .cornerRadius(4)
                .padding(.top)
        }
    }
}

struct ReviewItem_Previews: PreviewProvider {
    static var previews: some View {
        ReviewItem(review: Review(author: "Waddle Dee",username: "waddle17", rating: "8.5", review: "Best animu ever!"))
            .previewLayout(.sizeThatFits)
    }
}
