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
    @State private var friend = User()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        animeStore.signOut()
                        //isPresentingAddFriendView = true
                        
                    }) {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .navigationTitle("My Friends")
            .sheet(isPresented: $isPresentingAddFriendView) {
                NavigationView {
                    AddFriendView(friend: $friend)
                        .navigationTitle("Find Friends")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingAddFriendView = false
                                }
                            }
                        }
                }

            }
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
