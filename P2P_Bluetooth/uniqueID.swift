//
//  uniqueID.swift
//  P2P_Bluetooth
//
//  Created by LostZ on 2023/6/13.
//
// TODO: let username: String = LoginPageView().username

import Foundation

func userNames() -> [String: String] {
    
    // example of list contains two users and an empty dict
    // var ListOfNames = ["Sunny", "Dr. Mendes"]
    var dictionaryOfNames: NSMutableDictionary = [:]
    
    // UUID stuff
    let id = UUID().uuidString
    dictionaryOfNames[id] = "Sunny"
    return dictionaryOfNames as! [String : String]
}

