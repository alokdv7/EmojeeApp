//
//  Emojis+CoreDataProperties.swift
//  Emojis
//
//  Created by Alok Yadav on 11/06/23.
//
//

import Foundation
import CoreData

extension Emojis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emojis> {
        return NSFetchRequest<Emojis>(entityName: "Emojis")
    }

    @NSManaged public var key: String?
    @NSManaged public var image: Data?

}

extension Emojis : Identifiable {}
