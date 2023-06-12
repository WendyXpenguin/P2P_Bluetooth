//
//  ChatRow.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//
// TODO: displaying name and pictures

import SwiftUI

struct ChatRow: View {
    
    let chat: Chat
    
    var body: some View {
        HStack {
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack{
                        Text(chat.person.name)
                            .bold()
                        Spacer()
                        
                        // TODO: descriptive information here, like the date. start with Text()
                        // TODO: how to synchronize the time using an APPLE built-in function
                        Text(chat.messages.last?.date.descriptiveString() ?? "")
                    }
                    HStack {
                        Text(chat.messages.last?.text ?? "")
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .frame(height: 50, alignment: .top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 40)
                    }
                }
                Circle()
                    .foregroundColor(chat.hasUnreadMessage ? .mint : . clear)
                    .frame(width: 18, height: 18)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height:80)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat.sampleChat[0])
    }
}
