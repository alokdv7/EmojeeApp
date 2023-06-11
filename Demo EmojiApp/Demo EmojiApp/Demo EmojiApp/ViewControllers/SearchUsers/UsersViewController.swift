//
//  UsersViewController.swift
//  UsersViewController
//
//  Created by Alok Yadav on 11/06/23.
//

import UIKit

private let reuseIdentifier = "UserCell"

class UsersViewController: UICollectionViewController {
    
    
    var collectionDataSource:CollectionViewDataSource<UserCell>!
    private var userListViewModel:UserListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListViewModel = UserListViewModel()
        self.collectionView!.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        setupDataSource()
        setupUI()
    }
    
    private func setupDataSource(){
        collectionDataSource = CollectionViewDataSource(identifier: reuseIdentifier, viewModel: userListViewModel?.userModel ?? [])
        self.collectionView.dataSource = collectionDataSource
    }
    
    private func setupUI(){
        self.navigationItem.title = "Users"
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if userListViewModel?.deleteUserFromDisk(index: indexPath) == true {
            userListViewModel?.userModel.remove(at: indexPath.row)
            setupDataSource()
            collectionView.reloadData()
        }
    }
}
