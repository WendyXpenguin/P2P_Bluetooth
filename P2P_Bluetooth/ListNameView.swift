//
//  ContentView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/9.
// This is the View for our APP

import SwiftUI

struct ListNameView: View {
    @StateObject var ViewModel = ChatsViewModel()
    
    let chats = Chat.sampleChat
    
    @State private var query = ""
    
    var body: some View {
        NavigationView{
            List {ForEach(ViewModel.getSortedFiltereChats(query: query)) { chat in
                ZStack{
                    ChatRow(chat: chat)
                    NavigationLink(destination: {
                        ChatRoomView(chat: Chat.sampleChat[0])
                        
                    }) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 0)
                    .opacity(0)
                }
            }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $query)
            .navigationTitle("Friends")
            .navigationBarItems(trailing: Button(action: {}){
                Image(systemName: "plus.message")
                    .foregroundColor(Color.mint)
                
            })
        }
    }
}
        
        // two maps to handle the user names and IDs
        
        
struct ListNameView_Previews: PreviewProvider {
            static var previews: some View {
                ListNameView()
            }
        }
