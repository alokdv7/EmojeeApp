//
//  APIPackets.swift
//  APIPackets
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation
// MARK:API Packect
struct EmojiList:Requestable{
    var baseUrl: BaseUrls = .getEmojis
}

struct SearchUserPacket:Requestable{
    var baseUrl: BaseUrls
    init(query:String){
        baseUrl = .searchUser(query)
    }
}

struct AppleRepo:Requestable{
    
    var baseUrl: BaseUrls
}
