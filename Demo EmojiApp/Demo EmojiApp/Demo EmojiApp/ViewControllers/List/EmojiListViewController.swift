
//
//  EmojiListViewController.swift
//  EmojiListViewController
//
//  Created by Alok Yadav on 10/06/23.
//

import UIKit

private let reuseIdentifier = "EmojiCell"

class EmojiListViewController: UICollectionViewController {
    
    var emojis:[EmojiModel]?
    var collectionDataSource:CollectionViewDataSource<EmojiCell>!
    private var emojiListViewModel:EmojiListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiListViewModel = EmojiListViewModel(items: emojis?.map({ item in
            let modal = EmojiViewModel(url: item.value as! String)
            modal.delegate = emojiListViewModel
            return modal
        }) ??  [])
        self.collectionView!.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        setupDataSource()
        setupUI()
    }
    
    private func setupDataSource(){
        collectionDataSource = CollectionViewDataSource(identifier: reuseIdentifier, viewModel: emojiListViewModel?.emojis ?? [])
        self.collectionView.dataSource = collectionDataSource
    }
    
    private func setupUI(){
        self.navigationItem.title = "Emoji List"
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        emojiListViewModel?.emojis.remove(at: indexPath.row)
        setupDataSource()
        collectionView.reloadData()
    }
}
