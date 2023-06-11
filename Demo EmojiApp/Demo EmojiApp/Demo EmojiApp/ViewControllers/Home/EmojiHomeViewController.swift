//
//  EmojiHomeViewController.swift
//  EmojiHomeViewController
//
//  Created by Alok Yadav on 09/06/23.
//

import UIKit

class EmojiHomeViewController: UIViewController {

    // MARK: - Properties & Object Creation

    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var emojiView:UIImageView!

    var emojiHomeViewModel:EmojiHomeViewModel?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        emojiHomeViewModel = EmojiHomeViewModel(delegate: self)
        setupUI()
    }
    // MARK: IBAction
    
  @IBAction func getEmojis(){
        if emojiHomeViewModel?.emojiModels.count == 0{
            emojiHomeViewModel?.getAllEmoji()
        }
    }
    
    @IBAction func changeEmoji(){
        updateView(string: emojiHomeViewModel?.getRandomEmoji() ?? "")
    }
    
    @IBAction func emolistTapped(){
        showListOfEmojis()
    }
    
    @IBAction func avatarsListtapped(){
        showListOfUsers()
    }
    
    @IBAction func appleRepoTapped(){
        showListOfRepos()
    }
    
    @IBAction func searchEmoji(){
        emojiHomeViewModel?.searchEmoji()
    }
    // MARK: Private Function
    private func setupUI(){
        self.navigationItem.title = "Emoji Home"
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.textColor = UIColor(named: "ThemeColor")
        }
    }
    private func updateView(string:String){
        var image:UIImage?
        guard let url = URL(string: string) else {
            return
        }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else{
                return
            }
            image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                if let image = image {
                    self?.emojiView.image = image
                }
            }
        }
    }
    
    
    
}
// MARK: Extension
extension EmojiHomeViewController:EmojiHomeUpdatable{
    
    func listOfEmojiRecieved(model: [EmojiModel]) {
        emojiHomeViewModel?.emojiModels = model
        updateView(string: emojiHomeViewModel?.getRandomEmoji() ?? "")
    }
    
    func searchCompleted(data:[SearchUser]){
        emojiHomeViewModel?.serachResult = data
        emojiHomeViewModel?.saveUsersInDisk()
        DispatchQueue.main.async {
            self.searchBar.text = ""
        }
    }
}

extension EmojiHomeViewController{
    func showListOfEmojis(){
        let vc = EmojiListViewController(nibName: "EmojiListViewController", bundle: nil)
        vc.emojis = emojiHomeViewModel?.emojiModels
        self.show(vc, sender: self)
        
    }
    
    func showListOfUsers(){
        let vc = UsersViewController(nibName: "UsersViewController", bundle: nil)
        self.show(vc, sender: self)
    }
    
    func showListOfRepos(){
        let vc = RepoViewController(nibName: "RepoViewController", bundle: nil)
        self.show(vc, sender: self)
    }
}

