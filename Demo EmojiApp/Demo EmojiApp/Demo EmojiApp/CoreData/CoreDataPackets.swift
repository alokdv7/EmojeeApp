//
//  CoreDataPackets.swift
//  CoreDataPackets
//
//  Created by Alok Yadav on 11/06/23.
//

import Foundation
import CoreData

// MARK: Models/Entities

struct EmojiPacket:Persistable{
    var managedObject: NSManagedObject? = nil
    var entityName: String = "Emojis"
    var entityData: [String : Any]
    
}

struct UsersPacket:Persistable{
    var managedObject: NSManagedObject? = nil
    var entityName: String = "Users"
    var entityData: [String : Any]
}
