//
//  RepoViewController.swift
//  RepoViewController
//
//  Created by Alok Yadav on 11/06/23.
//

import UIKit
protocol RepoVCUpdatable{
    func repoResponseRecieved()
}

class RepoViewController: UITableViewController {
    var vmObject:RepoListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        vmObject = RepoListViewModel(vc: self)
        vmObject.getRepo()
        tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
    }
    
    private func setupUI(){
        self.navigationItem.title = "Apple Repos"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vmObject.repoModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell")
        if (vmObject.repoModels.count - 1) == indexPath.row{
            vmObject.currentPage = vmObject.currentPage + 1
            vmObject.getRepo()
        }
        cell?.textLabel?.text = vmObject.repoModels[indexPath.row].repo
        return cell!
    }
}

extension RepoViewController:RepoVCUpdatable{
    func repoResponseRecieved() {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
}


