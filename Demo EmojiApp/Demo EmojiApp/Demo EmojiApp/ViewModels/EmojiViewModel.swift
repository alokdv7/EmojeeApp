//
//  EmojiViewModel.swift
//  EmojiViewModel
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation
import UIKit
import CoreData

protocol ImageLodable{
    var networkManager:NetwrokManager { get }
    func loadImage(url:String,completion:@escaping(Data)->())->UUID?
    func cancelLoading(uuid:UUID?)
}

extension ImageLodable{
    func cancelLoading(uuid:UUID?){}
}

protocol CollectionDataSourceImplementable{
    func configureCell<T>(cell:T)

}

class EmojiViewModel:ImageLodable,CollectionDataSourceImplementable{

    var networkManager = NetwrokManager()
    var emoji:String
    var uuid:UUID?
    var delegate:ImagesUpdatabel?
    typealias cell = EmojiCell
    
    init(url:String){
        emoji = url

    }
    
    func configure(completion:@escaping(Data)->()){
        uuid = loadImage(url: emoji, completion: { [weak self,emoji] data  in
            
            if let savedData = self?.delegate?.getSaveImage(url: emoji){
                completion(savedData)
            }else{
                let packet = EmojiPacket(entityData: ["key":emoji,"image":data as Any])
                CoreDataManager().saveSingleObject(packet: packet) { status in
                    if true{
                        completion(data)
                    }
                }
            }
            
        })
    }
    
    func loadImage(url:String,completion:@escaping(Data)->())->UUID?{
        if let data = delegate?.getSaveImage(url: url) {
            completion(data)
            return nil
        }
        return networkManager.requestImage(url: url) {[weak self] result in
            switch result{
            case .success(let data):
                self?.delegate?.saveImageLocal(url: url, data: data)
                completion(data)
            case .failure:
                break
            }
        }
    }
    
    func cancelLoading(uuid:UUID?){
        if let id = uuid{
            networkManager.cancelRequest(uuid: id)
        }
    }
    
    func configureCell<T>(cell:T) {

        if let emojiCell = cell as? EmojiCell{
            emojiCell.delegate = self
            emojiCell.configureCell()
        }
    }
    
}



