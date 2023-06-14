//
//  ChatModel.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import Foundation

struct Chat: Identifiable {
    var id: UUID { person.id }
    let person: Person
    var messages: [Message]
    var hasUnreadMessage = false
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
    // static persons list
}

struct Message: Identifiable {
    
    enum MessageType{
        case Sent, Received
    }
    
    let id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date: Date) {
        self.date = date
        self.type = type
        self.text = text
    }
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}

//extension Chat {
//
//    static let sampleChat = [
//        Chat(person: Person(name: "Wendy", imgString: "img1"), messages: [
//            Message("Hey Wendy", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
//            Message("Hey Sunny, What are you doing?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
//            Message("I am jsut developing an WhatsApp Clone App", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
//            Message("Oh wow, that is really cool", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
//            Message("Yeah, I have been pretty busy with it", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1))
//                    ],
//                    hasUnreadMessage: true)
//            ]
//}
