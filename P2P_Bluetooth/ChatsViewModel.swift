//
//  ChatsViewModel.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import Foundation

class ChatsViewModel: ObservableObject {
    @Published var chats = Chat.sampleChat
    func getSortedFiltereChats(query: String) -> [Chat] {
        let sortedChats = chats.sorted {
            guard let date1 = $0.messages.last?.date else {return false}
            guard let date2 = $1.messages.last?.date else {return false}
            return date1 > date2
        }
        
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter {$0.person.name.lowercased().contains(query.lowercased())}
    }
}
