//
//  FriendListView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/23/22.
//

import SwiftUI

struct FriendListView: View {
    
    @EnvironmentObject var animeStore: AnimeStore
    @State private var isPresentingAddFriendView = false
    @State var friendID = ""
    
    var body: some View {
        List {
            HStack {
                TextField("Enter user id", text: $friendID)
                Button("Add friend") {
                    animeStore.addFriend(friendID: friendID)
                    friendID = ""
                }
            }
            .padding(.bottom)
            ForEach(animeStore.currentFriends, id: \.id) { friend in
//                NavigationLink(destination: AnimeListView()                        .navigationTitle("\(friend.name)'s Anime List")){
                    FriendItem(user: friend)
//                }
            }
            .onDelete { offsets in
                animeStore.currentFriends.remove(atOffsets: offsets)
            }
            Spacer()
        }
        .listStyle(.inset)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    animeStore.signOut()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
                
            }
        }
        .navigationTitle("My Friends")
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
            .environmentObject(AnimeStore())
    }
}
