//
//  Users+CoreDataProperties.swift
//  Users
//
//  Created by Alok Yadav on 11/06/23.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: Data?

}

extension Users : Identifiable {}
