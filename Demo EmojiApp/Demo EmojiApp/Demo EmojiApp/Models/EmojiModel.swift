//
//  EmojiModel.swift
//  EmojiModel
//
//  Created by Alok Yadav on 09/06/23.
//

import Foundation
import UIKit

// MARK: Models & Protocol
protocol KeyValueModel{

    var key:String { get set }
    var value:Any{ get set }
    init(key:String,value:String)
}

struct EmojiModel:KeyValueModel{

    var key: String
    var value: Any

    init(key:String,value:String){
        self.key = key
        self.value = value
    }

    init(key:String,value:Data){
        self.key = key
        self.value = value
    }
}

