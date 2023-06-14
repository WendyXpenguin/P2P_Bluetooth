//
//  LoginPage.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/13.
//

import SwiftUI

struct LoginPageView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: UUID().uuidString) ?? ""
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Enter Your Name", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button("Sign In") {
                        authenticateUser(username: username)
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: ListNameView(), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String) {
        if username.lowercased() != "" {
            showingLoginScreen = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
