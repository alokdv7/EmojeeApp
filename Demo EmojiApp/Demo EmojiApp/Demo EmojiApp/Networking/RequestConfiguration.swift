//
//  NetworkPacket.swift
//  NetworkPacket
//
//  Created by Alok Yadav on 09/06/23.
//

import Foundation

// MARK: Network Configration
enum ServerList:String{

    case production = "https://api.github.com"
}

enum HTTPMethods:String{
    case get = "GET"
}

enum BaseUrls{
    case getEmojis
    case searchUser(String)
    case appleRepo(Int)
    var rawValue:String{
        get{
            switch self {
            case .getEmojis:
                return "/emojis"
            case .searchUser(let query):
                return "/users/\(query)"
            case .appleRepo(let page):
                return "/users/apple/repos?page=\(page)&per_page=\(10)"
            }
        }
    }
}

// MARK: Requetable Protocol

/// Command Pattern for encapsulation
protocol Requestable{

    var baseUrl:BaseUrls { get }
    var method:HTTPMethods { get }
}

extension Requestable{
   
    var method:HTTPMethods{
        return .get
    }

    func getCompleteUrl()->String{
        return AppGlobals.activeServer.rawValue+baseUrl.rawValue
    }
}
