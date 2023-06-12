//
//  ChatRoomView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import SwiftUI

struct ChatRoomView: View {
    
    @EnvironmentObject var viewModel: ChatsViewModel
    
    let chat: Chat
    
    var body: some View {
        Text(chat.person.name)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView(chat: Chat.sampleChat[0])
    }
}
