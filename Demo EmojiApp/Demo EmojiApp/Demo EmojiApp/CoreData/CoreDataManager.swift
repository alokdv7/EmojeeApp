//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Alok Yadav on 11/06/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{

    func saveSingleObject(packet:Persistable,completion:
                            @escaping((Bool)->())) {

        DispatchQueue.main.async {
            if let  moc = packet.managedObjectContext {
                let entity = NSEntityDescription.entity(forEntityName: packet.entityName, in: moc)
                let object = NSManagedObject(entity: entity!, insertInto: packet.managedObjectContext)
                for item in packet.entityData{
                    object.setValue(item.value, forKey: item.key)
                }
                do{
                    try moc.save()
                    completion(true)
                }
                catch{
                    completion(false)
                }
            }
        }
    }
    
    func delete(packet:Persistable)->Bool {
        if let  moc = packet.managedObjectContext {
                moc.delete(packet.managedObject!)
                try? moc.save()
                return true
    
        }else{
            return false
        }
    }
    
    func fetchAll(packet:Persistable)->[NSManagedObject]? {
        if let  moc = packet.managedObjectContext {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: packet.entityName)
            do{
                if let data = try (moc.fetch(fetch) as? [NSManagedObject] ) {
                    return data
                }else{
                    return nil
                }
            }
            catch{
                return nil
            }
        }else{
            return nil
        }
    }
    
}
