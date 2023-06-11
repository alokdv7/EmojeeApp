//
//  EmojiListViewModel.swift
//  EmojiListViewModel
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation
import CoreData

protocol EmojiHomeUpdatable{
    func listOfEmojiRecieved(model:[EmojiModel])
    func searchCompleted(data:[SearchUser])
}

struct EmojiHomeViewModel{
    
    var emojiModels = [EmojiModel]()
    
    var delegate:EmojiHomeUpdatable
    var emojiHomeVC:EmojiHomeViewController
    var serachResult = [SearchUser]()

    init(delegate:EmojiHomeViewController){
        self.delegate = delegate
        emojiHomeVC = delegate
    }
    
    func getAllEmoji(){
        
        _ =  NetwrokManager().requestData(packet: EmojiList(), keyValueModel: EmojiModel.self) { result in
            switch result{
            case .success(let items):
                delegate.listOfEmojiRecieved(model: items)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getRandomEmoji()->String{
        if emojiModels.count > 0 {
            let random = Int.random(in: 0..<emojiModels.count)
            return emojiModels[random].value as! String
        }else{
            return ""
        }
    }
    
    
    func searchEmoji(){

        if let query = emojiHomeVC.searchBar.text,query != ""  {
            let packet = SearchUserPacket(query: query)
            _ =  NetwrokManager().requestData(packet: packet, model: SearchUser.self) { result in
                switch result{
                case .success(let result):
                    delegate.searchCompleted(data: result)
                case.failure:
                    break
                }
            }
            
        }
    }
    
    func saveUsersInDisk(){
        
        for item in serachResult{
            _ = NetwrokManager().requestImage(url: item.avatar_url, completion: { result in
                switch result{
                case .success(let data):
                    let dataPacket = UsersPacket( entityData: ["id":item.id,"name":item.login,"image":data])
                    CoreDataManager().saveSingleObject(packet: dataPacket) { result in
                        print(result)
                    }
                case .failure:
                    break
                }
            })
            
        }
        
    }
}
