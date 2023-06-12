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
        VStack {
            Text("Hello, what a good day!")
        }
        .padding()
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
                    message in if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        HStack{
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(.white)
                                .background(.mint.opacity(0.8))
                                .padding(.horizontal, 16)
                                .cornerRadius(0)
                                .padding(.bottom, 10)
                        }
                    } else {
                        HStack{
                            Text(message)
                                .padding()
                                .foregroundColor(.white)
                                .background(.mint.opacity(0.8))
                                .padding(.horizontal, 16)
                                .cornerRadius(0)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }.rotationEffect(.degrees(180))
                .background(Color.gray.opacity(0.1))
            
            
            
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
