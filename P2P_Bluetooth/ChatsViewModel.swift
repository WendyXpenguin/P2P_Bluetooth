//
//  ChatsViewModel.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import Foundation

class ChatsViewModel: ObservableObject {
    static let persons = [Person(name: "Wendy", imgString: "img1"), "Wendy", "Dr. Mendes", "Sam", "Lily", "Erica", "Josh"]
    static let messages = [
        Message("Hey Wendy", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Hey Sunny, What are you doing?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("I am jsut developing an WhatsApp Clone App", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Oh wow, that is really cool", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("Yeah, I have been pretty busy with it", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1))
                ]
    static let chats = [Chat(persons[0], message[0]), Chat(person[1], message[1])]
    
    // arrays of persons, messages, and chats
    // person[0], message[0]
    // pass the name of the users
    // 1. do the thing above
    // 2. create a map from person to chat - connect the person to the login
    // 3. switch
    @Published var chats = chats
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
    
    func getSectionMessage(for chat: Chat) -> [[Message]] {
        var res = [[Message]]()
        var tmp = [Message]()
        for message in chat.messages {
            if let firstMessage = tmp.first {
                let daysBetween = firstMessage.date.daysBetween(date: message.date)
                if daysBetween >= 1 {
                    res.append(tmp)
                    tmp.removeAll()
                    tmp.append(message)
                } else {
                    tmp.append(message)
                }
            } else {
                tmp.append(message)
            }
        }
        res.append(tmp)
        return res
    }
    
    func markAsUnread(_ newValue: Bool, chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id}) {
            chats[index].hasUnreadMessage = newValue
        }
    }
    
    func sendMessage(_ text: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id}) {
            let message = Message(text, type: .Sent)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
    
}
