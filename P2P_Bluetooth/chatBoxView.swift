//
//  ContentView.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/9.
// This is the View for our APP

import SwiftUI

struct chatBoxView: View {
    var body: some View {
        VStack{
            textBoxView()
        }
    }
}

struct textBoxView: View {
    var body: some View {
        ZStack(alignment:.center){
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 5)
        }
        .frame(width: 270, height: 570.0)
        .foregroundColor(Color.mint)
        .padding([.leading, .bottom, .trailing], 40.0)
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        chatBoxView()
    }
}
