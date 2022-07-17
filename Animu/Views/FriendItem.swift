//
//  FriendItem.swift
//  Animu
//
//  Created by Timmy Nguyen on 7/15/22.
//

import SwiftUI

struct FriendItem: View {
    
    let user: User
    
    var body: some View {
        HStack {
            Image("waddle")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).stroke(.white)
                }
            VStack(alignment: .leading) {
                Text(user.name)
                Text("@\(user.username)")
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "ellipsis")
        }
    }
}

struct FriendItem_Previews: PreviewProvider {
    static var previews: some View {
        FriendItem(user: User(id: "123", name: "Timmy Nguyen", email: "timmy123@gmail.com", username: "timmypass17", animeList: []))
    }
}
