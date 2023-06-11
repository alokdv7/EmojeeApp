//
//  UserViewModel.swift
//  UserViewModel
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation

class UserViewModel:ImageLodable,CollectionDataSourceImplementable{

    var networkManager = NetwrokManager()

    private var user:Data
    private var id :Int64

    var delegate:ImagesUpdatabel?

    typealias cell = UserCell
    
    init(url:Data,id:Int64){
        user = url
        self.id = id
    }
    
    func configure()->Data?{
        return user
    }
    
    func getId()->Int64{
        return self.id
    }
    
    func loadImage(url:String,completion:@escaping(Data)->())->UUID?{
        if let data = delegate?.getSaveImage(url: url) {
            completion(data)
            return nil
        }
        return nil
    }
    
    func configureCell<T>(cell:T) {

        if let userCell = cell as? UserCell{

            userCell.configureCell(data: user)
        }
    }
    
}
