//
//  EmojiCell.swift
//  EmojiCell
//
//  Created by Alok Yadav on 10/06/23.
//

import UIKit
// MARK: Custom Cell

class EmojiCell: UICollectionViewCell {

    @IBOutlet weak var emojiView:UIImageView!
    weak var delegate :EmojiViewModel?
    var uuid:UUID?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        emojiView.image = nil
        delegate?.cancelLoading(uuid: uuid)
    }
    
    func configureCell(){
        self.uuid = delegate?.uuid
        delegate?.configure { data in
            DispatchQueue.main.async {
                self.emojiView.image = UIImage(data: data)
            }
        }
    }
}

