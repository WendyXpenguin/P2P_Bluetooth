//
//  ChatsViewModel.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import Foundation

class ChatsViewModel: ObservableObject {
    // arrays of persons, messages, and chats
    // person[0], message[0]
    // pass the name of the users
    // 1. do the thing above
    static let persons = [Person(name: "Wendy", imgString: "img1"), Person(name:"Dr. Mendes", imgString: "img2"), Person(name: "Sam", imgString: "img3"), Person(name: "Lily", imgString: "img4"), Person(name: "Erica", imgString: "img5"), Person(name: "Josh", imgString: "img6")]
    static let messages = [
        Message("Hey Wendy", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Hey Sunny, What are you doing?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("I am jsut developing an WhatsApp Clone App", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("Oh wow, that is really cool", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
        Message("Yeah, I have been pretty busy with it", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        Message("Hi Sunny", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("I am bored", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
        Message("How are you doing today?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 10)),
        Message("Not much. Just enjoying the summer", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 10))
    ]
    
    static let chats = [
        Chat(person: persons[0], messages: [messages[0], messages[1], messages[2], messages[3], messages[4]]),
        Chat(person: persons[3], messages: [messages[5], messages[6]]),
        Chat(person: persons[5], messages: [messages[7], messages[8]])
    ]
    
    // 2. create a map from person to chat - connect the person to the login
    static let chatsMap = ["Wendy": chats[0],
                           "Lily" : chats[1],
                           "Josh" : chats[2]
    ]
    
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
