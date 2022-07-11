//
//  AddFriendView.swift
//  Animu
//
//  Created by Timmy Nguyen on 6/26/22.
//

import SwiftUI

struct AddFriendView: View {
    
    @Binding var friend: User
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView(friend: .constant(User()))
    }
}
