//
//  ContentView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/9.
// This is the View for our APP

import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Let's chat!"]
    var body: some View {
        VStack{
            HStack{
                Text("UserName")
                    .font(.largeTitle)
                    .bold()
                Image(systemName: "text.bubble.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.mint)
            }
            ScrollView{
                ForEach(messages, id: \.self) {
                    message in Text(message)
                }
            }
            HStack{
                TextField("Type your message here", text : $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                Button {
                    sendMessage(message: messageText)
                } label : {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size:26))
                .padding(.horizontal, 10)
                .foregroundColor(Color.mint)
            }
            .padding()
        }
    }
    func sendMessage(message: String){
        withAnimation{
            messages.append("[USER]" + message)
            self.messageText = ""
        }
    }
}

// two maps to handle the user names and IDs


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
