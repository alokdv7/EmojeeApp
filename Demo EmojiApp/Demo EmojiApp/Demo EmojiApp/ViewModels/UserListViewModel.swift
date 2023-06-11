//
//  UserListViewModel.swift
//  UserListViewModel
//
//  Created by Alok Yadav on 11/06/23.
//

import Foundation

class UserListViewModel{

    var userModel:[UserViewModel]

    private var coreDataObjects:[Users]?

    init(){
        let packet = UsersPacket(entityData: [:])
        coreDataObjects = CoreDataManager().fetchAll(packet: packet) as? [Users]
        userModel = coreDataObjects?.compactMap({ item in
            return UserViewModel(url: item.image!, id: item.id)
        }) ?? []
    }
    
    func deleteUserFromDisk(index:IndexPath)->Bool{
        var packet = UsersPacket(entityData: [:])
        let object = coreDataObjects?[index.row]
        packet.managedObject = object
        return CoreDataManager().delete(packet: packet)
    }
    
}
