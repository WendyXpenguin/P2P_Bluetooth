//
//  ChatRoomView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/12.
//

import SwiftUI

struct ChatRoomView: View {
    @EnvironmentObject var ViewModel: ChatsViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let chat: Chat
    
    @State private var text = ""
    @FocusState private var isFocused
    @State private var messageIDToScroll: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                    .navigationBarBackButtonHidden(true)
                   .toolbar(content: {
                       ToolbarItem (placement: .navigationBarLeading)  {
                                
                           Button(action: {
                               presentationMode.wrappedValue.dismiss()
                           }, label: {
                               Image(systemName: "arrow.left")
                               .foregroundColor(.black)
                               Text("")
                           })
                     
                           
                           
                       }
                       })
            GeometryReader { reader in
                ScrollView {
                    ScrollViewReader { scrollReader in
                        getMessagesView(viewWidth: reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageIDToScroll) { _ in
                                if let messageID = messageIDToScroll {
                                    scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear{
                                if let messageID = chat.messages.last?.id {
                                    scrollTo(messageID: messageID, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                }
                            }
                    }
                }
            }
            .padding(.bottom, 5)
            .background(Color.gray.opacity(0.3))
            
            toolbarView()
            
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: navBarTrailingBtn)
        .navigationBarItems(trailing: navBarLeadingBtn)
        .onAppear{
            ViewModel.markAsUnread(false, chat: chat)
        }
    }
    
    var navBarLeadingBtn: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                Text(chat.person.name).bold()
            }
            .foregroundColor(.black)
        }
        .padding(.trailing)
    }
    
    var navBarTrailingBtn: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "star")
                    .foregroundColor(.black)
            }
        }
    }
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 37
            HStack {
                TextField("Please type...", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .background(
                            Circle()
                                .foregroundColor(text.isEmpty ? .gray : .mint)
                        )
                }
                .disabled(text.isEmpty)
            }
            .frame(height: height)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
    }
    
    func sendMessage() {
        if let message = ViewModel.sendMessage(text, in: chat) {
            text = ""
            messageIDToScroll = message.id
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessagesView(viewWidth: CGFloat) -> some View  {
        LazyVGrid(columns: columns, spacing: 0, pinnedViews: [.sectionHeaders]) {
            let sectionMessages = ViewModel.getSectionMessage(for: chat)
            ForEach(sectionMessages.indices, id: \.self) { sectionIndex in let messages = sectionMessages[sectionIndex]
                Section(header: sectionHeader(firstMessage: messages.first!)) {
                    ForEach(messages) {message in
                        let isReceived = message.type == .Received
                        HStack {
                            ZStack {
                                Text(message.text)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(isReceived ? Color.brown.opacity(0.5) : .mint.opacity(0.9))
                            .cornerRadius(13)
                            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing)
                            .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
                        .id(message.id)
                    }
                }
            }
        }
    }
    func sectionHeader(firstMessage message: Message) -> some View{
        ZStack{
            Text(message.date.descriptiveString(dateStyle: .medium))
                .font(.system(size:14, weight: .regular))
                .frame(width: 120)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(.black.opacity(0.2)))
        }
        .padding(.vertical, 5)
        .frame(maxWidth: . infinity)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChatRoomView(chat: ChatsViewModel.chatsForUser1[0])
                .environmentObject(ChatsViewModel())
        }
    }
}
