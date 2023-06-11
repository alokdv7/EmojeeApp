//
//  EmojiListViewModel.swift
//  EmojiListViewModel
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation
import UIKit
import CoreData

protocol ImagesUpdatabel{
    func saveImageLocal(url:String,data:Data)
    func getSaveImage(url:String)->Data?
    var loadedImages: [String : Data] {get set}
}

class EmojiListViewModel:ImagesUpdatabel{
    
    var listOfEntity: [NSEntityDescription]?
    var emojis :[EmojiViewModel]
    var loadedImages: [String : Data] = [:]

    init(items:[EmojiViewModel]){
        emojis = items
        let packet = EmojiPacket(entityData: [:])
        guard let values = CoreDataManager().fetchAll(packet: packet) as? [Emojis] else {
            return
        }
        for item in values{
            loadedImages[item.key!] = item.image
        }
        
        
        if emojis.count == 0{
            emojis = values.map({ item in
                let modal = EmojiViewModel(url: item.key ?? "")
                modal.delegate = self
                return modal
            })
        }
    }
    
    func saveImageLocal(url:String,data:Data){
        loadedImages[url]=data
    }
    
    func getSaveImage(url:String)->Data?{
        if let data = loadedImages[url] {
            return data
        }else{
            return nil
        }
    }

}
