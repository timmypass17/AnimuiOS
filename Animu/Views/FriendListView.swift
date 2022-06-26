//
//  FriendListView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/23/22.
//

import SwiftUI

struct FriendListView: View {
    @EnvironmentObject var animeStore: AnimeStore
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { animeStore.signOut() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("My Friends")
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
