//
//  ChatRoomView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import SwiftUI

struct ChatRoomView: View {
    
    @EnvironmentObject var ViewModel: ChatsViewModel

    let chat: Chat
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Let's chat!")
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            ViewModel.markAsUnread(false, chat: chat)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView(chat: Chat.sampleChat[0])
            .environmentObject(ChatsViewModel())
    }
}
