//
//  UserCell.swift
//  UserCell
//
//  Created by Alok Yadav on 10/06/23.
//

import UIKit

// MARK: Custom Cell

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        emojiView.image = nil
    }
    
    func configureCell(data:Data){
        self.emojiView.image = UIImage(data: data)
    }
}
