//
//  CollectionViewDataSource.swift
//  CollectionViewDataSource
//
//  Created by Alok Yadav on 10/06/23.
//

import Foundation
import UIKit

// MARK: DataSopurce Method

class CollectionViewDataSource<T>: NSObject, UICollectionViewDataSource{
    
    let reuseIdentifier:String
    let listViewModel:[CollectionDataSourceImplementable]

    
    init(identifier:String,viewModel: [CollectionDataSourceImplementable]) {
        self.reuseIdentifier = identifier
        self.listViewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let model = listViewModel[indexPath.row]
        if cell is T{
            model.configureCell(cell: cell)
        }
        return cell
    }
}

