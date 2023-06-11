//
//  RepoModel.swift
//  RepoModel
//
//  Created by Alok Yadav on 11/06/23.
//

import Foundation

class RepoListViewModel{

    var repoModels:[RepoViewModel] = []
    var delegate:RepoVCUpdatable
    var currentPage = 1

    init(vc:RepoViewController){
        delegate = vc
    }

    func getRepo(){
        let packet = AppleRepo(baseUrl: .appleRepo(currentPage))
        _ = NetwrokManager().requestData(packet: packet, model: Repos.self) { [weak self] result in
            switch result{
            case .success(let repos):
                self?.repoModels.append(contentsOf: repos.map({ item in
                    return RepoViewModel(name: item.name)
                }))
                self?.delegate.repoResponseRecieved()
            case .failure:
                break
            }
        }
    }
}


