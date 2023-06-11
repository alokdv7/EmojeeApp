//
//  CoreDataConfiguration.swift
//  CoreDataConfiguration
//
//  Created by Alok Yadav on 11/06/23.
//

import Foundation
import CoreData
import UIKit

// MARK: Persistable

protocol Persistable{
    var entityName: String { get }
    var entityData: [String:Any]  { get }
    var managedObjectContext: NSManagedObjectContext? { get }
    var managedObject: NSManagedObject? { get }
}

extension Persistable {
    var managedObjectContext :NSManagedObjectContext? {
        if let appdel = UIApplication.shared.delegate as? AppDelegate{
            return appdel.persistentContainer.viewContext
        }else{
            return nil
        }
    }
}

