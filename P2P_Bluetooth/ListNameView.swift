//
//  ContentView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/9.
// This is the View for our APP

import SwiftUI

struct ListNameView: View {
    @StateObject var ViewModel = ChatsViewModel()
    @State private var query = ""
    private var username: String
    init(_ username: String) {
        self.username = username
        ViewModel.changeUsername(username: username)
    }
    
    
    

    var body: some View {
        NavigationView{
            List {ForEach(ViewModel.getSortedFiltereChats(query: query)) { chat in
                ZStack{
                    ChatRow(chat: chat)
                    NavigationLink(destination: {
                        ChatRoomView(chat: chat)
                            .environmentObject(ViewModel)
                    }) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 0)
                    .opacity(0)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(action: {
                        ViewModel.markAsUnread(!chat.hasUnreadMessage, chat: chat)
                    }) {
                        if chat.hasUnreadMessage {
                            Label("Read", systemImage: "pencil.circle")
                        } else {
                            Label("Read", systemImage: "circle.fill")
                        }
                    }
                }.tint(.mint)
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
                ListNameView("Lily")
            }
        }
